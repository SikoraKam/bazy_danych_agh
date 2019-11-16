--lab5

--5.1
--1
SELECT COUNT(*) as liczba_czekoladek FROM czekoladki cz;
--2
SELECT COUNT(*) as liczba_czekoladek FROM czekoladki cz WHERE cz.nadzienie IS NOT NULL
lub
SELECT COUNT(cz.nadzienie) as liczba_czekoladek FROM czekoladki cz
--3
SELECT SUM(sztuk) AS suma, idpudelka FROM zawartosc 
GROUP BY(idpudelka)
ORDER BY suma Desc
LIMIT 1

--4
SELECT SUM(sztuk) AS suma, idpudelka FROM zawartosc 
GROUP BY(idpudelka)
--5
SELECT SUM(zaw.sztuk) AS suma, zaw.idpudelka FROM zawartosc zaw
JOIN czekoladki cz ON cz.idczekoladki = zaw.idczekoladki
WHERE cz.orzechy IS NULL
GROUP BY(idpudelka)
--6
SELECT SUM(zaw.sztuk) AS suma, zaw.idpudelka, cz.czekolada FROM zawartosc zaw
JOIN czekoladki cz ON cz.idczekoladki = zaw.idczekoladki
WHERE cz.czekolada = 'mleczna'
GROUP BY(idpudelka,cz.czekolada)

--5.2
--1
SELECT p.idpudelka, SUM(cz.masa*z.sztuk) as masa
FROM
    czekoladki cz
    INNER JOIN zawartosc z ON cz.idczekoladki = z.idczekoladki
    INNER JOIN pudelka p ON z.idpudelka = p.idpudelka
GROUP BY p.idpudelka
--2 // to napewno tak?
SELECT MAX(pp.masa) FROM (

SELECT p.idpudelka, SUM(cz.masa*z.sztuk) as masa
FROM
    czekoladki cz
    INNER JOIN zawartosc z ON cz.idczekoladki = z.idczekoladki
    INNER JOIN pudelka p ON z.idpudelka = p.idpudelka
GROUP BY p.idpudelka
) pp
--3
SELECT AVG(pp.masa) FROM (

SELECT p.idpudelka, SUM(cz.masa*z.sztuk) as masa
FROM
    czekoladki cz
    INNER JOIN zawartosc z ON cz.idczekoladki = z.idczekoladki
    INNER JOIN pudelka p ON z.idpudelka = p.idpudelka
GROUP BY p.idpudelka
) pp
--4
SELECT p.idpudelka, (SUM(cz.masa*z.sztuk) / SUM(z.sztuk)) as srednia
FROM
  czekoladki cz
  INNER JOIN zawartosc z ON cz.idczekoladki = z.idczekoladki
  INNER JOIN pudelka p ON z.idpudelka = p.idpudelka
GROUP BY p.idpudelka

--5.3
--1
SELECT extract (day from z.datarealizacji) as dzien_zamowienia, COUNT(z.idzamowienia) as suma_zamowien
FROM zamowienia z
GROUP BY dzien_zamowienia
ORDER BY dzien_zamowienia ASC
--2
SELECT COUNT(*) FROM zamowienia z
--3
SELECT SUM(p.cena * a.sztuk) AS wartosc
FROM pudelka p
JOIN artykuly a ON a.idpudelka=p.idpudelka
--4 //oni maja COUNT(k)
SELECT k.idklienta, COUNT(z.idzamowienia), c.sm
  FROM klienci k 
	INNER JOIN zamowienia z ON k.idklienta = z.idklienta
	INNER JOIN 
	      ( 
		SELECT k.idklienta as idklienta, SUM(a.sztuk * p.cena) as sm FROM klienci k 
		INNER JOIN zamowienia z ON k.idklienta = z.idklienta
		INNER JOIN artykuly a ON z.idzamowienia = a.idzamowienia 
		INNER JOIN pudelka p ON a.idpudelka = p.idpudelka GROUP BY k.idklienta 
	      ) c ON k.idklienta = c.idklienta
	GROUP BY k.idklienta, c.sm
	ORDER BY k.idklienta ASC

--5.4
--1
select idczekoladki, count(idpudelka)
from zawartosc 
group by idczekoladki 
order by 2 desc 
limit 1;
--2
SELECT z.idpudelka, SUM(z.sztuk) as ilosc
FROM zawartosc z 
JOIN czekoladki cz ON cz.idczekoladki=z.idczekoladki
WHERE cz.orzechy IS NULL
GROUP BY z.idpudelka
--3
SELECT cz.idczekoladki,COUNT(*) FROM zawartosc z
	INNER JOIN czekoladki cz ON z.idczekoladki=cz.idczekoladki 
		GROUP BY cz.idczekoladki
		ORDER BY COUNT(*) ASC LIMIT 1;
--4
SELECT p.idpudelka, SUM(a.sztuk) as ilosc
FROM pudelka p 
JOIN artykuly a ON a.idpudelka=p.idpudelka
GROUP BY p.idpudelka
ORDER BY ilosc DESC

--5.5
--1
SELECT EXTRACT(QUARTER FROM datarealizacji) as q, COUNT(*)
 FROM zamowienia 
 GROUP BY q
--2
SELECT EXTRACT(month FROM datarealizacji) as m, COUNT(*)
 FROM zamowienia 
 GROUP BY m
--3
SELECT k.miejscowosc, COUNT(z.idzamowienia) FROM klienci k
JOIN zamowienia z ON z.idklienta=k.idklienta
GROUP BY k.miejscowosc
--4
SELECT DISTINCT k.miejscowosc, count(z.idzamowienia) 
	FROM klienci k 
	JOIN zamowienia z USING(idklienta) 
	GROUP BY miejscowosc

--5.6  // pytanie czy tak moze byc zapis
--1
SELECT SUM(pp.suma) FROM 
(SELECT p.idpudelka, SUM(c.masa * z.sztuk) * p.stan AS suma
FROM    pudelka p
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki)
        GROUP BY p.idpudelka) pp

--2

--5.7
--1
SELECT pp.idpudelka,pp.cena - t.sum AS zysk FROM 
(
	SELECT z.idpudelka,SUM(cz.koszt * z.sztuk)
	FROM czekoladki cz 
		INNER JOIN zawartosc z USING(idczekoladki)
			GROUP BY z.idpudelka
) AS t
INNER JOIN pudelka pp USING(idpudelka);
--2
--wlasne:
SELECT SUM(wszystkie.zysk) FROM
(SELECT  SUM((pp.cena - t.koszt) * a.sztuk) AS zysk FROM
(SELECT z.idpudelka, SUM(cz.koszt * z.sztuk) as koszt FROM czekoladki cz
  JOIN zawartosc z USING(idczekoladki)
  GROUP BY z.idpudelka ) as t
JOIN pudelka pp USING(idpudelka)
JOIN artykuly a ON a.idpudelka = pp.idpudelka ) wszystkie

--lub

SELECT SUM(wszystkie.zysk) FROM
(SELECT  SUM(pp.cena - t.koszt) * a.sztuk AS zysk FROM
(SELECT z.idpudelka, SUM(cz.koszt * z.sztuk) as koszt FROM czekoladki cz
  JOIN zawartosc z USING(idczekoladki)
  GROUP BY z.idpudelka ) as t
JOIN pudelka pp USING(idpudelka)
JOIN artykuly a ON a.idpudelka = pp.idpudelka
GROUP BY a.sztuk ) wszystkie


--lepsze:
SELECT  SUM(Zysk.zysk * a.sztuk)
FROM    artykuly a
        JOIN (
            SELECT p.idpudelka, p.cena - SUM(c.koszt * z.sztuk) AS Zysk
            FROM    pudelka p
                    JOIN zawartosc z USING(idpudelka)
                    JOIN czekoladki c USING(idczekoladki)
            GROUP BY p.idpudelka
        ) AS Zysk USING(idpudelka);

