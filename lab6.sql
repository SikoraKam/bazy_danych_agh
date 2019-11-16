--lab6
--6.1
--1
--wg tego
INSERT INTO klienci (
    idklienta,
    nazwa,
    ulica,
    miejscowosc,
    kod,
    telefon
) VALUES (
    900000003,
    'Konrad',
    'Testowa',
    (SELECT miejscowosc FROM klienci WHERE idklienta = 80),
    '31-000',
    '000 000 000'
);
--2
wstawiac kolejne po przecinkach

--6.2
insert into czekoladki values(tam gdzie chcemy wpisujemy, tam gdzie nie chcemydajemy null)

--6.3
delete from czekoladki where idczekoladki='X91' or idczekoladki= 'M98'

insert into czekoladki(te w ktore kolumny chcemy wstawicto podajemy) values (wartosci odpowiadajace wskazanym kolumnom) 

--6.4
--1
update klienci set nazwa='Nowak Iza' where nazwa='Matusiak Iza'
--2
Update czekoladki set koszt=koszt*0.9 where idczekoladki in ('W98','M98','X91')
--3
UPDATE czekoladki SET koszt = (SELECT koszt FROM czekoladki WHERE idczekoladki = 'W98') WHERE nazwa = 'Nieznana Nieznajoma';

--lub

UPDATE czekoladki cz1 SET koszt = cz2.koszt
FROM czekoladki cz2
WHERE cz1.nazwa = 'Nieznana Nieznajoma' AND cz2.idczekoladki = 'W98';

--4
Update klienci set miejscowosc='Piotrograd' where miejscowosc = 'Leningrad'
--5
UPDATE czekoladki cz SET koszt = cz.koszt + 0.15 WHERE cz.idczekoladki ~'.9[1-9]'

--lub

UPDATE czekoladki cz SET koszt = cz.koszt + 0.15 WHERE substr(cz.idczekoladki, 2, 2)::int > 90

--6.5
--1
delete from klienci where nazwa ~'Hłasko\s.*'
--2
DELETE FROM klienci WHERE idklienta > 91
--3
DELETE FROM czekoladki WHERE koszt >= 0.45 OR masa >= 36 OR masa = 0


--6.6
INSERT INTO pudelka (
        idpudelka,
        nazwa,
        opis,
        cena, 
        stan
    )  VALUES (
        'tsss',
        'Ogniste Fasolki',
        'Halleluja jak pieką',
         14,
         701
    ), (
        'kebs',
        'Kebsikowe kąski',
        'Lepsze niż pod 13',
         12,
         701
    );
    
    INSERT INTO zawartosc (
        idpudelka,
        idczekoladki, 
        sztuk
    ) VALUES ( 
        'tsss',
        'b02',
         4 
    ), (
        'tsss',
        'm09',
         4 
    ), (
        'tsss',
        'b03', 
        4
     ), (
        'tsss', 
        'b05', 
        4 
    ), (
        'kebs',
        'm09',
         4 
    ), (
        'kebs',
        'b03', 
        4
     ), (
        'kebs', 
        'b05', 
        4 
    ), (
        'kebs', 
        'b05', 
        4 
    )
--6.7
% W naszych danych pusty string = NULL
    % Znak oddzielający dane = |
    
    COPY czekoladki FROM stdin with (null '', delimiter '|');
    b01|Płomienna ekstaza|gorzka|łuskane|krem|Orzechy w kremie, zatopione w gorzkiej czekoladzi...|0.30|20
    ... itd ...


