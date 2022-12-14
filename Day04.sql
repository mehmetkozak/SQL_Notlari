--ÖDEV
-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz
select*from calisanlar2;
select*from markalar;

select marka_id,calisan_sayisi from markalar 
where marka_isim in (select isyeri from calisanlar2 where sehir='Ankara')

--ALIASES

CREATE TABLE calisanlar3 (
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);
INSERT INTO calisanlar3 VALUES(123456789, 'Ali Can','Istanbul'); 
INSERT INTO calisanlar3 VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO calisanlar3 VALUES(345678901, 'Mine Bulut', 'Izmir');

SELECT*FROM calisanlar3

--Eğer iki sütunun verilerini birleştirmek istersek concet sembolu || kullanırız
Select calisan_id As id,calisan_isim ||' '|| calisan_dogdugu_sehir As calisan_bilgisi from calisanlar3
Select calisan_id As id, concat (calisan_isim, calisan_dogdugu_sehir) As calisan_bilgisi from calisanlar3

--IS NULL CONDİTİON

CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');--parçalı ekleme yaptık
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli'); 

select*from insanlar

--Name sutununda null olan değerleri liseteleyin

select isim from insanlar where isim is null;
select isim from insanlar where isim is not null;--null olmayan değerler listeledik

--İnsanlar tablosunda null değer almış verileri no name olarak değiştirin

update insanlar set isim='No name' where isim is null
select*from insanlar

--ORDER BY CLAUSE
/*
	ORDER BY komutu belli bir field’a gore NATURAL ORDER olarak siralama
	yapmak icin kullanilir
	ORDER BY komutu sadece SELECT komutu Ile kullanilir.
	Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
	Büyükten küçüğe yada küçükten büyüğe sıralama yapabiliriz
	Default olarak küçükten büyüğe sıralama yapar
	Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız
*/

CREATE TABLE insanlar2
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar2 VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar2 VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar2 VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar2 VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar2 VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar2 VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

select*from insanlar2

--Insanlar tablosundaki datalari adres’e gore siralayin

select*from insanlar2 ORDER BY adres;

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
select*from insanlar2 where isim='Mine' Order by ssn;

--NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir

--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin
select*from insanlar2 where soyisim='Bulut' order by 2--Buradaki 2 isim fieldı 2.sıradaki sutunda olduğu için(field numarası)

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select*from insanlar2 order by ssn desc

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
select*from insanlar2 order by isim, soyisim desc

--ORDER BY field name LENGHT
-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız.
SELECT isim,soyisim from insanlar2 order by Length(soyisim) desc;

-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
Select isim ||' '|| soyisim as isim_soyisim from insanlar2 order by length(isim||soyisim) 

-- 									GROUP BY CLAUSE
-- Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
-- komutuyla birlikte kullanılır
CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

select*from manav;

--Isme gore alinan toplam urunleri bulun

Select isim, sum(urun_miktar) from manav Group by isim

-- Urun ismine gore urunu alan toplam kisi sayisi
Select urun_adi,count(isim) from manav group by urun_adi

