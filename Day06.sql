					
					--  JOINS
/*
2 Tablodaki datalari Birlestirmek icin kullanilir.
Su ana kadar gordugumuz Union,Intersect ve Minus sorgu sonuclari icin kullanilir 
Tablolar icin ise JOIN kullanilir
5 Cesit Join vardir
1) INNER JOIN iki Tablodaki ortak datalari gosterir
2) LEFT JOIN Ilk datada olan tum recordlari gosterir
3) RIGHT JOIN Ikinci tabloda olan tum recordlari gosterir
4) FULL JOIN Iki tablodaki tum recordlari gosterir
5) SELF JOIN Bir tablonun kendi icinde Join edilmesi ile olusur.
*/

CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'Toyota'); 
INSERT INTO sirketler VALUES(101, 'Honda');  
INSERT INTO sirketler VALUES(102, 'Ford');
INSERT INTO sirketler VALUES(103, 'Hyundai');

CREATE TABLE siparisler  (
siparis_id int, 
sirket_id int, 
siparis_tarihi date
);
INSERT INTO siparisler VALUES(11, 101, '2020-04-17'); 
INSERT INTO siparisler VALUES(22, 102, '2020-04-18'); 
INSERT INTO siparisler VALUES(33, 103, '2020-04-19');
INSERT INTO siparisler VALUES(44, 104, '2020-04-20'); 
INSERT INTO siparisler VALUES(55,  105, '2020-04-21');

select*from sirketler
select*from siparisler

--		1) INNER JOIN
--1) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id vesiparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi FROM sirketler 
Inner join siparisler On sirketler.sirket_id=siparisler.sirket_id

--		2)LEFT JOIN
/*
 NOT :
1) Left Join’de ilk tablodaki tum record’lar gosterilir.
2) Ilk tablodaki datalara 2.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilir ancak
ortak olmayan datalar icin o kisimlar bos kalir
3) Ilk yazdiginiz Tablonun tamamini aldigi icin hangi tabloyu istedigimize karar verip once onu yazmaliyiz
 */

--2) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id vesiparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler LEFT join siparisler On sirketler.sirket_id=siparisler.sirket_id

--    3)RİGHT JOİN
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi 
FROM sirketler RIGHT join siparisler On sirketler.sirket_id=siparisler.sirket_id

--	 4) FULL JOİN
/*
NOT :
	1) FULL Join’de iki tabloda var olan tum record’lar gosterilir.
	2) Bir tabloda olup otekinde olmayan data’lar bos kalir
	*/
	
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi 
FROM sirketler FULL join siparisler On sirketler.sirket_id=siparisler.sirket_id

--  5) SELF JOİN
Drop table personel cascade-- eski personel tablosunu sildik

CREATE TABLE personel  (
id int,
isim varchar(20),  
title varchar(60),  yonetici_id int
);
INSERT INTO personel VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel VALUES(3, 'Ayse Gul', 'QA Lead', 4); 
INSERT INTO personel VALUES(4, 'Fatma Can', 'CEO', 5);

select*from personel
-- 1)Her personelin yanina yonetici ismini yazdiran bir tablo olusturun

select isim from personel
Select p1.isim as personel_isim,p2.isim as yonetici_isim from personel p1 INNER join personel p2 On p1.yonetici_id=p2.id

-- 								LIKE Condition
/*
	LIKE condition WHERE ile kullanilarak SELECT, INSERT, UPDATE, veya DELETE
	statement ile calisan wildcards’a(özel sembol) izin verir.. Ve bize pattern matching yapma
	imkani verir.
*/

Drop table musteriler

CREATE TABLE musteriler  (
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);
INSERT INTO musteriler (id, isim, gelir) VALUES (1001, 'Ali', 62000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1002, 'Ayse', 57500); 
INSERT INTO musteriler (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1004, 'Fatma', 42000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1006, 'ahmet', 82000);


-- 1) % => 0 veya birden fazla karakter belirtir.
/*
LIKE kullanımında büyük küçük harf gözetmeksizin sonuç almak istersek ILIKE kullanırız
LIKE yerine ~~ sembollerini kullanabiliriz. Eğer büyük küçük harf gözetmeksizin kullanmak istersek ~~* sembollerini kullanırız
*/
-- SORU : Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin

select*from musteriler where isim ~~* 'A%'

-- Soru- Ismi e harfi ile BİTEN musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
select isim,gelir from musteriler where isim like '%e'

--Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
select isim,gelir from musteriler where isim like '%er%'

-- 2) _=> sadece bir karakteri gosterir.
 
-- SORU : Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
Select*from musteriler where isim ~~ '_atma'

-- SORU : ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
Select*from musteriler where isim like '_a%'

-- SORU : Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin
Select*from musteriler where isim like '__s%'

/*	
3) REGEXP_LIKE =>	Daha karmaşık sorgular için herhangi bir kod, metin icerisinde istenilen yazi
veya kod parcasinin aranip bulunmasini saglayan kendine ait soz dizimi olan bir yapidir.
(REGEXP_LIKE) PostgreSQL de ‘’ ~ ‘’ karekteri ile kullanilir

*/
CREATE TABLE kelimeler  (
id int UNIQUE,
kelime varchar(50) NOT NULL,  Harf_sayisi int
);
INSERT INTO kelimeler VALUES (1001, 'hot', 3);  
INSERT INTO kelimeler VALUES (1002, 'hat', 3); 
INSERT INTO kelimeler VALUES (1003, 'hit', 3); 
INSERT INTO kelimeler VALUES (1004, 'hbt', 3); 
INSERT INTO kelimeler VALUES (1008, 'hct', 3); 
INSERT INTO kelimeler VALUES (1005, 'adem', 4);
INSERT INTO kelimeler VALUES (1006, 'selim', 5);  
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);

select*from kelimeler
--SORU : Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin
select*from kelimeler where kelime ~ 'h[ai]t'

--SORU : Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin
select*from kelimeler where kelime ~* 'h[a-k]t'

--SORU : a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select*from kelimeler where kelime ~* '^[as]'

--SORU : m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
select*from kelimeler where kelime ~ '[mf]$'

--				NOT LIKE Condition  ==>  NOT LIKE = !~

Select*from kelimeler

--SORU 1) ilk harfi h olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
Select*from kelimeler where kelime Not like 'h%'

--SORU 2)  a harfi icermeyen kelimelerin tum bilgilerini yazdiran QUERY yazin
Select* from kelimeler where kelime !~~ '%a%'

--SORU 3) ikinci ve ucuncu harfi ‘de’ olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select*from kelimeler where kelime Not Like '_de%'

--SORU 4) 2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yaSELECT *
select*FROM kelimeler
WHERE kelime !~ '[_eio]'


/*
UPPER – LOWER - INITCAP
Tablolari yazdirirken buyuk harf, kucuk harf veya ilk harfleri buyuk digerleri
kucuk harf yazdirmak icin kullaniriz
 */
 
--SORU: -- Kelimeler tablosundaki kelime sutunundaki verileri once hepsi buyuk harf, 
--sonra kucuk harf ve ilk harfleri buyuk olacak sekilde yazdiralim

Select Upper (kelime) from kelimeler -- Hepsi büyük harf oldu
Select Lower (kelime) from kelimeler -- Hepsi küçük harf oldu
Select initcap (kelime) from kelimeler -- İlk harfler büyük, sonrakiler küçük harf oldu