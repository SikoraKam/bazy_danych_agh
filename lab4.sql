-- lab4

--4.1
--1
iloczyn kartezjanski w 2
bezuzyteczne: 1 i ?

--4.2
--1
SELECT z.datarealizacji, z.idzamowienia, k.nazwa FROM klienci k INNER JOIN zamowienia z ON k.idklienta = z.idklienta WHERE k.nazwa ~ '\sAntoni';
--2
SELECT z.datarealizacji, z.idzamowienia, k.ulica FROM klienci k JOIN zamowienia z ON k.idklienta = z.idklienta WHERE k.ulica ~ '.*/.*';
--3
SELECT z.datarealizacji, z.idzamowienia, k.miejscowosc FROM klienci k JOIN zamowienia z ON k.idklienta = z.idklienta WHERE extract (month from datarealizacji) = 11 AND extract (year from datarealizacji)=2013 AND k.miejscowosc = 'Kraków';

--4.3
--1
Select k.nazwa, k.ulica, k.miejscowosc, z.datarealizacji FROM klienci k JOIN zamowienia z ON k.idklienta = z.idklienta WHERE z.datarealizacji > current_date - interval '5years';
--2
Select k.nazwa, k.ulica, k.miejscowosc, z.datarealizacji, p.nazwa FROM 
klienci k 
JOIN zamowienia z ON k.idklienta = z.idklienta
JOIN artykuly a ON a.idzamowienia = z.idzamowienia
JOIN pudelka p ON p.idpudelka = a.idpudelka
 WHERE p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna');
--3
Select k.nazwa, k.ulica, k.miejscowosc, k.idklienta FROM klienci k WHERE idklienta IN (SELECT idklienta FROM zamowienia);
lub SELECT DISTINCT k.idklienta, k.nazwa, k.ulica FROM klienci k JOIN zamowienia z ON z.idklienta = k.idklienta;
--4
SELECT k.nazwa, k.ulica, k.miejscowosc FROM klienci k LEFT join zamowienia z ON k.idklienta = z.idklienta WHERE z.idzamowienia IS NULL;
--5
SELECT k.nazwa, k.ulica, k.miejscowosc, z.datarealizacji FROM klienci k JOIN zamowienia z ON k.idklienta = z.idklienta WHERE z.datarealizacji between '2013-11-01' AND '2013-11-30';
--6 
Select distinct k.nazwa, zaw.sztuk, z.datarealizacji, p.nazwa AS "nazwa pudelka" FROM 
klienci k
JOIN zamowienia z ON k.idklienta = z.idklienta
JOIN artykuly a ON a.idzamowienia = z.idzamowienia
JOIN pudelka p ON p.idpudelka = a.idpudelka
JOIN zawartosc zaw ON zaw.idpudelka = p.idpudelka
 WHERE p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna') and zaw.sztuk >= 2;
--7
Select distinct k.nazwa, zaw.sztuk, cz.orzechy, p.nazwa AS "nazwa pudelka" FROM 
klienci k
JOIN zamowienia z ON k.idklienta = z.idklienta
JOIN artykuly a ON a.idzamowienia = z.idzamowienia
JOIN pudelka p ON p.idpudelka = a.idpudelka
JOIN zawartosc zaw ON zaw.idpudelka = p.idpudelka
JOIN czekoladki cz ON cz.idczekoladki = zaw.idczekoladki
WHERE orzechy = 'migdały';

--4.4
--1
Select p.nazwa, p.opis, cz.nazwa AS "nazwa czekoladki", cz.opis AS "opis czekoladki" FROM
pudelka p 
JOIN zawartosc zaw ON zaw.idpudelka = p.idpudelka
JOIN czekoladki cz ON cz.idczekoladki = zaw.idczekoladki;
--2
Select p.nazwa, p.opis, cz.nazwa AS "nazwa czekoladki", cz.opis AS "opis czekoladki", p.idpudelka FROM
pudelka p 
JOIN zawartosc zaw ON zaw.idpudelka = p.idpudelka
JOIN czekoladki cz ON cz.idczekoladki = zaw.idczekoladki
WHERE p.idpudelka = 'heav';
--3
Select p.nazwa, p.opis, cz.nazwa AS "nazwa czekoladki", cz.opis AS "opis czekoladki", p.idpudelka FROM
pudelka p 
JOIN zawartosc zaw ON zaw.idpudelka = p.idpudelka
JOIN czekoladki cz ON cz.idczekoladki = zaw.idczekoladki
WHERE p.nazwa ~ '.*Kolekcja.*';

--4.5
--1
Select p.nazwa, p.opis, p.cena, cz.idczekoladki FROM
pudelka p 
JOIN zawartosc zaw ON zaw.idpudelka = p.idpudelka
JOIN czekoladki cz ON cz.idczekoladki = zaw.idczekoladki
WHERE cz.idczekoladki = 'd09';
--2
Select p.nazwa, p.opis, p.cena, cz.idczekoladki, cz.nazwa as "nazwa cz" FROM
pudelka p 
JOIN zawartosc zaw ON zaw.idpudelka = p.idpudelka
JOIN czekoladki cz ON cz.idczekoladki = zaw.idczekoladki
WHERE cz.nazwa ~ '^S';
--3
Select p.nazwa, p.opis, p.cena, cz.idczekoladki, cz.nazwa FROM
pudelka p 
JOIN zawartosc zaw ON zaw.idpudelka = p.idpudelka
JOIN czekoladki cz ON cz.idczekoladki = zaw.idczekoladki
WHERE zaw.sztuk >= 4;
--4
Select p.nazwa, p.opis, p.cena, cz.idczekoladki, cz.nadzienie FROM
pudelka p 
JOIN zawartosc zaw ON zaw.idpudelka = p.idpudelka
JOIN czekoladki cz ON cz.idczekoladki = zaw.idczekoladki
WHERE cz.nadzienie = 'truskawki';
--5 //jak to zrobić z except
Select p.nazwa, p.opis, p.cena, cz.idczekoladki, cz.czekolada FROM
pudelka p 
JOIN zawartosc zaw ON zaw.idpudelka = p.idpudelka
JOIN czekoladki cz ON cz.idczekoladki = zaw.idczekoladki
WHERE cz.czekolada <> 'gorzka';
--6
Select p.nazwa, p.opis, p.cena, cz.idczekoladki,zaw.sztuk, cz.nazwa as "cz n" FROM
pudelka p 
JOIN zawartosc zaw ON zaw.idpudelka = p.idpudelka
JOIN czekoladki cz ON cz.idczekoladki = zaw.idczekoladki
WHERE zaw.sztuk >= 3 and cz.nazwa = 'Gorzka truskawkowa';
--7
to samo co w 5
--8
podobnie
--9
podobnie

--4.6
--1 // jak zrobic z join
SELECT cz.idczekoladki, cz.nazwa FROM czekoladki cz WHERE cz.koszt > (SELECT cz2.koszt FROM czekoladki cz2 WHERE cz2.idczekoladki = 'd08');
--2
WITH gorka AS (SELECT a.idpudelka, k.nazwa FROM klienci k
  JOIN zamowienia z ON z.idklienta = k.idklienta
  JOIN artykuly a ON a.idzamowienia = z.idzamowienia
   WHERE k.nazwa = 'Górka Alicja' )
SELECT kk.nazwa FROM klienci kk
  JOIN zamowienia zz ON zz.idklienta = kk.idklienta
  JOIN artykuly aa ON aa.idzamowienia = zz.idzamowienia
  JOIN gorka ON gorka.idpudelka = aa.idpudelka
  WHERE gorka.nazwa <> kk.nazwa
  GROUP BY kk.nazwa
  ORDER  BY kk.nazwa ASC;

lub

WITH gorka AS (SELECT a.idpudelka FROM klienci k          --tu sie rozni
  JOIN zamowienia z ON z.idklienta = k.idklienta
  JOIN artykuly a ON a.idzamowienia = z.idzamowienia
   WHERE k.nazwa = 'Górka Alicja' )
SELECT kk.nazwa FROM klienci kk
  JOIN zamowienia zz ON zz.idklienta = kk.idklienta
  JOIN artykuly aa ON aa.idzamowienia = zz.idzamowienia
  JOIN gorka ON gorka.idpudelka = aa.idpudelka
  WHERE 'Górka Alicja' <> kk.nazwa              --tu sie rozni
  GROUP BY kk.nazwa
  ORDER  BY kk.nazwa ASC;

