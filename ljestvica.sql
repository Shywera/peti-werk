-- Peti werk: zajednička ljestvica (Supabase / PostgreSQL).
-- U Supabase projektu otvori SQL Editor, zalijepi sve i pokreni jednom.
-- Zatim u postavke.js upiši Project URL i javni "anon" ključ (Project Settings > API).

create table if not exists public.rezultati (
  id         bigint generated always as identity primary key,
  datum      date    not null,
  ime        text    not null check (char_length(btrim(ime)) between 2 and 24),
  ime_kljuc  text    generated always as (lower(btrim(ime))) stored,
  bodovi     integer not null check (bodovi between 0 and 500),
  sekundi    integer not null check (sekundi between 0 and 300),
  werkovi    text    not null check (werkovi ~ '^[0-2]{5}$'),   -- po odjelu: 2 točno, 1 blizu, 0 zastoj
  upisano    timestamptz not null default now(),
  unique (datum, ime_kljuc)                                     -- jedan rezultat po imenu na dan
);

alter table public.rezultati enable row level security;

-- Svi smiju čitati ljestvicu.
drop policy if exists "ljestvica je javna" on public.rezultati;
create policy "ljestvica je javna" on public.rezultati
  for select to anon using (true);

-- Upisati se smije samo rezultat za današnji dan (po hrvatskom vremenu). Izmjene i brisanja nema.
drop policy if exists "upis samo za danas" on public.rezultati;
create policy "upis samo za danas" on public.rezultati
  for insert to anon
  with check (datum = (now() at time zone 'Europe/Zagreb')::date);

grant select, insert on public.rezultati to anon;

-- Tjedna ljestvica: zbroj bodova po imenu od ponedjeljka do nedjelje.
create or replace function public.pw_tjedan(od date, do_ date)
returns table (ime text, bodovi bigint, dana bigint)
language sql stable
as $$
  select min(r.ime), sum(r.bodovi), count(*)
  from public.rezultati r
  where r.datum between od and do_
  group by r.ime_kljuc
  order by 2 desc, 3 desc
  limit 300;
$$;

grant execute on function public.pw_tjedan(date, date) to anon;
