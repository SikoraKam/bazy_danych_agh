lab10)
--2)

--1
Select z.datarealizacji, z.idzamowienia From zamowienia z Where z.idklienta in
 (Select k.idklienta from klienci k where k.nazwa ~ 'Antoni')
--2
Select z.datarealizacji, z.idzamowienia From zamowienia z Where z.idklienta in
 (select k.idklienta from klienci k where k.ulica ~ '.*/.*')
--3
Select z.datarealizacji, z.idzamowienia From zamowienia z Where z.idklienta in
(select k.idklienta from klienci k where miejscowosc = 'Kraków') AND z.datarealizacji between '2013-11-01' and '2013-11-30'

--3)
--1
Select k.nazwa, k.ulica, k.miejscowosc from klienci k where k.idklienta in
(select z.idklienta from zamowienia z where z.datarealizacji = '2013-11-12')
--2
Select k.nazwa, k.ulica, k.miejscowosc from klienci k where k.idklienta in
(select z.idklienta from zamowienia z where Extract(month form z.datarealizacji) =11  AND EXTRACT(YEAR FROM z.datarealizacji) = 2013)
--3
Select k.nazwa, k.ulica, k.miejscowosc from klienci k where k.idklienta in
(select z.idklienta from zamowienia z
join artykuly a on a.idzamowienia = z.idzamowienia
join pudelka p om p.idpudelka = a.idpudelka
WHere p.nazwa in ('Kremowa fantazja', 'Kolekcja jesienna') )
--4
Select k.nazwa, k.ulica, k.miejscowosc from klienci k where k.idklienta in
(select z.idklienta from zamowienia z
join artykuly a on a.idzamowienia = z.idzamowienia
join pudelka p om p.idpudelka = a.idpudelka
WHere p.nazwa in ('Kremowa fantazja', 'Kolekcja jesienna') and a.sztuk >=2)
--5 
zjoinowac pudelka z czekolada where orzechy = migdaly
--6
poprostu wybrac z zamowien 

--7
Select k.nazwa, k.ulica, k.miejscowosc from klienci k where not exists
(Select z.idklienta from zamowienia z where z.idklienta=k.idklienta)

--4)
--1
Select p.nazwa, p.opis, p.cena From pudelka p Where p.idpudelka in 
(Select z.idpudelka From zawartosc z where z.idpudelka = 'D09')
--2
Select p.nazwa, p.opis, p.cena From pudelka p Where p.idpudelka in 
(Select z.idpudelka From zawartosc z
join czekoladki c on c.idczekoladki=z.idczekoladki 
where c.nazwa = 'Gorzka truskawkowa')
--3
SELECT * FROM pudelka WHERE idpudelka IN (
      SELECT z.idpudelka FROM zawartosc z
      JOIN czekoladki cz ON cz.idczekoladki = z.idczekoladki
      WHERE cz.nazwa ~ '^[sS]'
    )
--4
SELECT * FROM pudelka WHERE idpudelka IN (
  SELECT idpudelka FROM zawartosc WHERE sztuk >= 4
)
--5,6,7,8,9 prosciutto

--5)
--1
Select cz.idczekoladki, cz.nazwa form czekoladki cz Where koszt > 
(Select cz1.koszt from czekoladki cz1 where cz1.idczekoladki = 'D08')
--2
Select k.nazwa form klienci k
 Join zamowienia z usung(idklienta)
join artykuly a using(idzamowienia)
join pudelka p using (idpudelka)
where p.idpudelka in(
	Select pp.idpudelka from kk.idklienta
	join zamowienia zz using(idklienta)
	join artykuly aa using(idzamowienia)
	join pudelka pp using(idpudelka)
	Where kk.nazwa = 'Górka Alicja')
and k.nazwa <> 'Górka Alicja'

--3
SELECT DISTINCT k.nazwa, k.miejscowosc FROM klienci k
    INNER JOIN zamowienia z USING(idklienta) 
    INNER JOIN artykuly a USING(idzamowienia)
    INNER JOIN pudelka p USING(idpudelka) 
    WHERE p.idpudelka IN
    (
    	SELECT pp.idpudelka FROM klienci kk 
    	INNER JOIN zamowienia zz USING(idklienta) 
    	INNER JOIN artykuly aa USING(idzamowienia) 
    	INNER JOIN pudelka pp USING(idpudelka) WHERE kk.miejscowosc='Katowice'
    )


--6)
--1
With query As(Select idpudelka, Sum(sztuk) as liczba_czekoladek_w_pudelku
 from zawartosc
 group by idpudelka)
Select p.nazwa, query.liczba_czekoladek_w_pudelku from pudelka p
Join query on p.idpudelka = query.idpudelka
Where query.liczba_czekoladek_w_pudelku >= All (Select liczba_czekoladek_w_pudelku form query)

--2
With query As(Select idpudelka, Sum(sztuk) as liczba_czekoladek_w_pudelku
 from zawartosc
 group by idpudelka)
Select p.nazwa, query.liczba_czekoladek_w_pudelku from pudelka p
Join query on p.idpudelka = query.idpudelka
where query.liczba_czekoladek_w_pudelku in (Select MIn(liczba_czekoladek_w_pudelku) FROM query)

--3
WITH query AS (
  SELECT idpudelka, SUM(sztuk) AS liczba_czekoladek_w_pudelku FROM zawartosc GROUP BY idpudelka
)
SELECT p.nazwa, query.liczba_czekoladek_w_pudelku FROM pudelka p
JOIN query ON p.idpudelka = query.idpudelka
WHERE query.liczba_czekoladek_w_pudelku > (
SELECT AVG(liczba_czekoladek_w_pudelku) FROM query)

--4
WITH query AS (
  SELECT idpudelka, SUM(sztuk) AS liczba_czekoladek_w_pudelku FROM zawartosc GROUP BY idpudelka
)
SELECT p.nazwa, query.liczba_czekoladek_w_pudelku FROM pudelka p
JOIN query ON p.idpudelka = query.idpudelka
WHERE query.liczba_czekoladek_w_pudelku IN (
SELECT MAX(liczba_czekoladek_w_pudelku) FROM query)
 OR 
query.liczba_czekoladek_w_pudelku IN (
SELECT MIN(liczba_czekoladek_w_pudelku) FROM query)


	










