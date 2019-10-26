3.1: 
//1
select idzamowienia, datarealizacji from czekoladki where datarealizacji between '2013-11-12' and '2013-11-20';
//2
select idzamowienia, datarealizacji from zamowienia where (datarealizacji between '2013-12-01' and '2013-12-06
') and (datarealizacji between '2013-12-15' and '2013-12-20');
//3
SELECT idzamowienia, datarealizacji FROM zamowienia WHERE datarealizacji BETWEEN '2013-12-01' AND '2013-12-31'
//4
select idzamowienia, datarealizacji from zamowienia where extract (month from datarealizacji) = '11';
//5
 SELECT idzamowienia, datarealizacji FROM zamowienia WHERE EXTRACT(month FROM datarealizacji) BETWEEN 11 AND 12;
//6
SELECT idzamowienia, datarealizacji FROM zamowienia WHERE EXTRACT(day FROM datarealizacji) BETWEEN 17 AND 19;
/ /7
SELECT idzamowienia, datarealizacji FROM zamowienia WHERE EXTRACT(week FROM datarealizacji) BETWEEN 46 AND 47

3.2:
//1
select idczekoladki, nazwa, czekolada, orzechy, nadzienie from czekoladki where nazwa ~'^S.*';
//2
select idczekoladki, nazwa, czekolada, orzechy, nadzienie from czekoladki where nazwa ~'^S.*i$';
//3
select idczekoladki, nazwa, czekolada, orzechy, nadzienie from czekoladki where nazwa ~'^S.* m.*';	
//4
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa ~ '^(A|B|C)';
//5
select idczekoladki, nazwa, czekolada, orzechy, nadzienie from czekoladki where nazwa ~'.*(o|O)rzech.*';
//6
select idczekoladki, nazwa, czekolada, orzechy, nadzienie from czekoladki where nazwa ~'^S(\S*)m(\S*)';
//7
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa ~ '(maliny|truskawki)'
//8
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa ~ '^[^D-KST]';
//9
 SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa ~ '^S(l|ł)od';
//10
 SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa ~ '^[^\s]+$';
 SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki WHERE nazwa ~ '^\w+$';	

3.3
//1
SELECT miejscowosc from klienci where miejscowosc ~ '\s+';

// 2
 SELECT nazwa FROM klienci WHERE telefon ~ '^0'
// 3
 SELECT nazwa FROM klienci WHERE telefon ~ '^[^0]'	

3.4
//1
SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki where masa between 15 and 24 UNION
Select idczekoladki, nazwa, masa, koszt FROM czekoladki where koszt between 0.15 and 0.24;
// 2
(SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE masa BETWEEN 25 AND 35)
EXCEPT
(SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE koszt BETWEEN 0.25 AND 0.35)
// 3
(
  (SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE masa BETWEEN 15 AND 24)
	INTERSECT
  (SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE koszt BETWEEN 0.15 AND 0.24)
)
  UNION
(
  (SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE masa BETWEEN 25 AND 35)
	INTERSECT
  (SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE koszt BETWEEN 0.25 AND 0.35)
)
//4
(SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE masa BETWEEN 15 AND 24)
INTERSECT
(SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE koszt BETWEEN 0.15 AND 0.24)
//5
(SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE masa BETWEEN 25 AND 35)
EXCEPT
(
  (SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE koszt BETWEEN 0.15 AND 0.24)
	UNION
  (SELECT idczekoladki, nazwa, masa, koszt FROM czekoladki WHERE koszt BETWEEN 0.29 AND 0.35)
)

3.5
//1
SELECT idklienta FROM klienci
EXCEPT
SELECT idklienta FROM zamowienia
//2
SELECT idpudelka FROM pudelka EXCEPT
SELECT idpudelka FROM artykuly;
//3
 chyba nie musi być tych .*
SELECT nazwa FROM klienci WHERE nazwa ~ '(.*)(rz|Rz)(.*)'
UNION
SELECT nazwa FROM czekoladki WHERE nazwa ~ '(.*)(rz|Rz)(.*)'
UNION
SELECT nazwa FROM pudelka WHERE nazwa ~ '(.*)(rz|Rz)(.*)'
//4
SELECT idczekoladki FROM public.czekoladki EXCEPT
SELECT idczekoladki FROM zawartosc;

3.6
--1
SELECT idmeczu,
 (Select sum(wynik) From unnest(gospodarze) As wynik) AS Gospodarze,
(Select sum(wynik) From unnest(goscie) As wynik) AS Goście
 FROM siatkowka.statystyki;
--2
SELECT
	idmeczu,
	(SELECT sum(wyniki) FROM unnest(gospodarze) AS wyniki) AS gospodarze,
	(SELECT sum(wyniki) FROM unnest(goscie) AS wyniki) AS goscie
FROM siatkowka.statystyki WHERE gospodarze[5] IS NOT NULL AND (gospodarze[5] > 15 OR goscie[5] > 15);
--3
    idmeczu,
    CONCAT (
        CASE WHEN gospodarze[1] > goscie[1] THEN 1 ELSE 0 END
        + CASE WHEN gospodarze[2] > goscie[2] THEN 1 ELSE 0 END
        + CASE WHEN gospodarze[3] > goscie[3] THEN 1 ELSE 0 END
        + CASE WHEN COALESCE(gospodarze[4], 0) > COALESCE(goscie[4], 0) THEN 1 ELSE 0 END
        + CASE WHEN COALESCE(gospodarze[5], 0) > COALESCE(goscie[5], 0) THEN 1 ELSE 0 END
    , ':',
        CASE WHEN goscie[1] > gospodarze[1] THEN 1 ELSE 0 END
        + CASE WHEN goscie[2] > gospodarze[2] THEN 1 ELSE 0 END
        + CASE WHEN goscie[3] > gospodarze[3] THEN 1 ELSE 0 END
        + CASE WHEN COALESCE(goscie[4], 0) > COALESCE(gospodarze[4], 0) THEN 1 ELSE 0 END
        + CASE WHEN COALESCE(goscie[5], 0) > COALESCE(gospodarze[5], 0) THEN 1 ELSE 0 END
    ) as wynik
FROM siatkowka.statystyki

--4
SELECT * FROM (
  SELECT idmeczu,
     	(SELECT sum(wyniki) FROM unnest(gospodarze) AS wyniki) as gospodarze,
     	(SELECT sum(wyniki) FROM unnest(goscie) AS wyniki) as goscie
  FROM siatkowka.statystyki
) as zap WHERE gospodarze > 100;
--5
SELECT * FROM (
  SELECT idmeczu,
     	gospodarze[1] as gosp_pierwszy_set,
     	(SELECT sum(wyniki) FROM unnest(gospodarze) AS wyniki) as gospodarze,
     	(SELECT sum(wyniki) FROM unnest(goscie) AS wyniki) as goscie
  FROM siatkowka.statystyki
) as query WHERE |/ gosp_pierwszy_set < log(2.0, gospodarze + goscie);

3.7



													