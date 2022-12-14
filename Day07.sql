--		 DISTINCT
-- DISTINCT clause, çağrılan terimlerden tekrarlı olanların sadece birincisini alır.

CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

Select*from musteri_urun

--Musteri_urun tablosundan urun isimlerini tekrarsız listeleyiniz

select distinct (urun_isim) from musteri_urun

---- Tabloda kac farkli meyve vardir ?

select count (distinct urun_isim) from musteri_urun

--		 FETCH NEXT (SAYI) ROW ONLY- OFFSET - LİMİT

-- 1) musteri_urun Tablosundan urun_id ye gore siralayiniz
-- 2) musteri_urun Tablosundan Sirali tablodan ilk 3 kaydi listeleyin
select*from musteri_urun order by urun_id fetch next 3 row only -- fetch ile çözüm
select*from musteri_urun order by urun_id limit 3  -- limit ile çözüm

CREATE TABLE maas 
(
id int, 
musteri_isim varchar(50),
maas int 
);
INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

--En yüksek maası alan müşteriyi listeleyiniz
select*from maas Order by maas desc limit 1

--en yüksek 2. maaşı bulalım
select*from maas Order by maas desc offset 1 limit 1  --offset : satır atlamak istediğimizde kullanırız

select*from maas Order by maas desc offset 1 fetch next 1 row only

--Maaş tablosundan en düşük 4.maaşı listeleyiniz
select*from maas Order by maas offset 3 limit 1

--	DDL		ALTER TABLE STATEMENT
/*
					
	ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns
	islemleri icin kullanilir.
	ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
 */
 drop table personel

CREATE TABLE personel  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select*from personel

--ADD kullanımı
--1) ADD default deger ile tabloya bir field ekleme

Alter table personel add ulke varchar(30)
Alter table personel add adres varchar(30) default 'Türkiye' ---HEpsine default olarak Türkiye yazıldı

--2) DROP tablodan sutun silme
Alter table personel Drop ulke

--3) RENAME COLUMN sutun adi degistirme
alter table personel rename adres to ikametgah

--4)RENAME tablonun ismini degistirme
alter table personel rename to isci
select*from isci

--5)TYPE/SET sutunlarin ozelliklerini degistirme. (MySql'de modify)
Alter table isci alter column ikametgah TYPE varchar(30), Alter column maas SET not null
/*
Eger numeric data tipine sahip bir sutunun data turune string bir data turu atamak istersek
TYPE varchar(30) USING(maas::varchar(30)) bu formati kullaniriz
*/
Alter table Alter column maas Type varchar(30) Using(maas::varchar(30))-- maaş sütunun data type'ini int den Varchara dönüştürdük

Drop table ogrenciler2
					--TRANSACTİON
/*
			TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT)
	Transaction veritabani sistemlerinde bir islem basladiginda baslar ve bitince sona erer. Bu
	islemler veritabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir.
 */

--TRANSACTİON(BEGIN - SAVEPOINT - ROLLBACK - COMMIT)
/*
Transaction baslatmak icin BEGIN komutu kullanmamiz gerekir ve Transaction'i sonlandirmak icin
	COMMIT komutunu calistirmaliyiz.
*/
 CREATE TABLE ogrenciler2
(
id serial, -- Serial data türü otomatik sıralama sayısı atar (1,2 ...)   -- INSERT INTO ile tabloya veri eklerken serial data turunu kullandigim veri degeri yerine DEFAULT yazariz
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);
BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to x;
COMMIT;
 
SELECT*FROM ogrenciler2
drop table ogrenciler2
 
 /*
	Transaction kullaniminda SERIAL data turu kullanimi tercih edilmez. Save pointten sonra ekledigimiz
	veride sayac mantigi ile calistigi icin sayacta en son hangi sayida kaldiysa ordan devam eder.
	NOT :PostgreSQL de Transaction kullanımı için «Begin;» komutuyla başlarız sonrasında tekrar
	yanlış bir veriyi düzelmek veya bizim için önemli olan verilerden
	sonra ekleme yapabilmek için "SAVEPOINT savepointismi" komutunu
	kullanırız ve bu savepointe dönebilmek için "ROLLBACK TO savepointismi" komutunu
	kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki
	verileri tabloda bize verir ve son olarak Transaction'ı sonlandırmak için mutlaka
	"COMMIT" komutu kullanılır.
 */