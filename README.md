# Peti werk

Dnevni kviz iz tiskare, za mobitel. Arak putuje kroz pet odjela (Papir, Priprema, Tisak, Dorada, Skladište),
a u svakom čeka jedno pitanje. Svi igrači isti dan dobiju ista pitanja. Tko odgovori točno na svih pet, ima
odrađen radni nalog.

## Kako se igra

- Prije prve igre upišeš ime. Pod tim imenom si na ljestvici.
- Pet pitanja, na svako jedan pokušaj i ograničeno vrijeme (30 do 45 sekundi).
- Točan odgovor nosi 60 bodova, brzina još do 40. Kod pitanja s brojem ili redoslijedom odgovor koji je blizu
  nosi 30 bodova.
- Krivi odgovor je zastoj u tom odjelu i vidi se na arku: valovit papir, kriva montaža, otisak izvan pasera, rez koji
  je pobjegao.
- Na kraju paleta dobije karticu: zelena bez zastoja, žuta s jednim ili dva, crvena s tri i više.
- Novi radni nalog stiže u ponoć. Do tada se može vježbati; vježba se ne boduje.

## Od čega se sastoji

Obična statična stranica, bez poslužitelja i bez alata za izgradnju.

| Datoteka | Što je |
|---|---|
| `index.html` | stranica |
| `tokens.css`, `stil.css` | boje, fontovi, razmaci i izgled |
| `scena.js` | crtež i animacija: arak, traka i pet odjela |
| `igra.js` | igra: dnevna pitanja, sat, bodovanje, rezultat, ljestvica |
| `pitanja.js` | pitanja; slaže se alatom, ne uređuje se rukom |
| `postavke.js` | adresa stranice i podaci za ljestvicu |
| `fonts/` | fontovi (Big Shoulders Display, IBM Plex Sans i Mono) |
| `ljestvica.sql` | tablica i pravila za zajedničku ljestvicu |

Lokalno: `python -m http.server` u ovoj mapi pa otvori `http://localhost:8000`.

## Objava

Igra je objavljena na `https://kai-sol.com/peti-werk/`, kao mapa `peti-werk/` u repozitoriju `shywera/web`.
Ovaj repozitorij je izvor: nakon izmjene kopiraj datoteke stranice (`index.html`, `*.css`, `*.js`, `favicon.svg`,
`fonts/`) u tu mapu. Ako se adresa promijeni, upiši je u `postavke.js` (`adresa`), jer se ona dijeli uz rezultat.

Fontovi su u mapi `fonts/` i učitavaju se s iste stranice, a ne s Google Fonts.

## Zajednička ljestvica

Stranica nema svoj poslužitelj, pa rezultate svih igrača treba negdje spremiti. Predviđen je besplatan
Supabase projekt:

1. Na supabase.com otvori projekt.
2. U SQL Editoru pokreni `ljestvica.sql`.
3. Iz Project Settings > API prepiši Project URL i ključ `anon` u `postavke.js`.

Dok to nije upisano, igra radi normalno, a umjesto ljestvice prikazuje tvoje zadnje rezultate na tom uređaju.

Ključ `anon` je javan po namjeni. Pravila u `ljestvica.sql` dopuštaju samo čitanje i upis jednog rezultata po
imenu na dan, bez izmjena i brisanja. Tko baš hoće, može upisati izmišljen rezultat: ovo je igra među kolegama,
a ne natjecanje s nagradama.

## Pitanja

Pitanja su iz prakse offsetnog tiska iz arka: papir i karton, priprema, tisak, dorada, skladište. Svako je
provjereno prema izvoru prije nego što uđe u igru. Alati kojima se pitanja slažu nisu u ovom repozitoriju.
U `pitanja.js` su zapisana kao base64, samo da odgovori ne stoje čitljivi onome tko slučajno otvori datoteku.

Koje pitanje dolazi koji dan određuje datum: u svakom odjelu pitanja se promiješaju i idu redom, pa se nijedno ne
ponovi dok se ne potroše sva iz tog odjela.
