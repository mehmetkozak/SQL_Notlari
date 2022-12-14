CREATE TABLE ogrenciler6
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler6 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler6 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler6 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler6 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler6 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler6 VALUES(127, 'Mustafa Bak', 'Ali', 99);
select * from ogrenciler6
-- İsmi Mustafa Bak ve Nesibe Yılmaz olan kayıtları silelim
DELETE FROM ogrenciler6 WHERE isim='Mustafa Bak' or isim = 'Nesibe Yilmaz';
-- Veli ismi Hasan datayi silelim
DELETE FROM ogrenciler6 WHERE veli_isim='Hasan';
-- TRUNCATE --
-- Bir tablodaki tüm verileri geri alamayacağımız şekilde siler. Şartlı silme yapmaz
TRUNCATE ogrenciler6
-- ON DELETE CASCADE
DROP TABLE if exists adresler -- Eğer tablo varsa tabloyu siler
INSERT INTO talebe VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebe VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebe VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebe VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebe VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO not1 VALUES ('123','kimya',75);
INSERT INTO not1 VALUES ('124', 'fizik',65);
INSERT INTO not1 VALUES ('125', 'tarih',90);
INSERT INTO not1 VALUES ('126', 'Matematik',90);
select * from talebeler2;
select * from notlar2;
-- Notlar tablosundan talebe_id'si 123 olan datayı silelim
DELETE FROM notlar WHERE talebe_id='123';
-- Talebeler tablosundan id'si 126 olan datayı silelim
DELETE FROM talebeler2 WHERE id='126';
CREATE TABLE talebe
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
CREATE TABLE not1(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebe(id)
on delete cascade
);
INSERT INTO talebe VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebe VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebe VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebe VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebe VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO not1 VALUES ('123','kimya',75);
INSERT INTO not1 VALUES ('124', 'fizik',65);
INSERT INTO not1 VALUES ('125', 'tarih',90);
INSERT INTO not1 VALUES ('126', 'Matematik',90);
select * from talebe
select * from not1
-- Talebeler tablosundan id'si 126 olan datayı silelim
DELETE FROM talebe WHERE id='126'

/*
    Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliği ile
parent tablo dan da veri silebiliriz. Yanlız ON DELETE CASCADE komutu kullanımında parent tablodan sildiğimiz
data child tablo dan da silinir
*/

--IN CONDİTİON

--Müşteriler tablosundan ürün ismi orange, apple veya apricot olan tüm veriler listeleyiniz
CREATE TABLE musteriler (
urun_id int,
musteri_isim varchar(50),
	urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange'); 
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

seLECT*FROM musteriler;
--sorunun çözümü
--1.yol in kullanmadan
seLECT*FROM musteriler where urun_isim='Orange' or urun_isim='Apricot' or urun_isim='Apple';--Bu uzun yol
--2.yol in kullanarak
seLECT*FROM musteriler where urun_isim in ('Orange','Apple','Apricot');

--NOT İN --> SAYILANLAR DIŞINDAKİNİ GETİRİR

seLECT*FROM musteriler where urun_isim NOT in ('Orange','Apple','Apricot');--SADECE PALM KALDIĞI İÇİN ONU GETİRDİ

--BETWEEN CONDİTİON
--Müşteriler tablosundan id'si 20 ile 40 arasında olan tüm verileri listeleyiniz

seLECT*FROM musteriler where urun_id between 20 and 40;

seLECT*FROM musteriler where urun_id not between 20 and 40;


--SUBQUERİES--> SORGU İÇİNDE SORGU DEMEKTİR
CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);
INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

CREATE TABLE markalar
(
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
INSERT INTO markalar VALUES(104, 'Nike', 19000);


select*from calisanlar2;
select*from markalar;

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.

select isim,maas,isyeri From calisanlar2 
where isyeri in (select marka_isim from markalar where calisan_sayisi>15000);

---- marka_id’si 101’den büyük olan marka çalişanlarinin 
--isim, maaş ve şehirlerini listeleyiniz.

select isim,maas,sehir from calisanlar2
where isyeri In (select marka_isim from markalar where marka_id>101);

				--AGGREGATE METHODLARDA SUBQUERY
select*from calisanlar2;
select*from markalar;
--Her markanın id'sini,ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yapınız

select marka_id,marka_isim,(select count(sehir) as sehir_sayisi from calisanlar2 where marka_isim=isyeri) from markalar;

--Her markanın ismini, calisan sayisini ve o markaya ait calisanlarin toplam maasini listeleyiniz

select marka_isim,calisan_sayisi,(select sum(maas) from calisanlar2 where isyeri=marka_isim) as toplam_maas from markalar;

--Her markanın ismini, calisan sayisini ve o markaya ait calisanlarin max ve min maasini listeleyen bir SORGU yapınız
select marka_isim,calisan_sayisi,
(select max(maas) from calisanlar2 where isyeri=marka_isim) as en_yuksek_maas,
(select min(maas) from calisanlar2 where isyeri=marka_isim) as en_dusuk_maas
from markalar;

--VİEW KULLANIMI
/*
Yaptığımız sorguları hafızayı alır ve tekrar bizden istenen sorgulama yerine view'e atadığımız ismi select ile çağırırız
*/
Create view maxminmaas
as
select marka_isim,calisan_sayisi,
(select max(maas) from calisanlar2 where isyeri=marka_isim) as en_yuksek_maas,
(select min(maas) from calisanlar2 where isyeri=marka_isim) as en_dusuk_maas
from markalar;

select* from maxminmaas; -- sürekli kullanacağımız tabloları "View" ile oluşturursak o sorguyu kaydetmiş oluyoruz.
						-- İstediğimiz zaman çağırıp kullanabilirz
						
						--EXIST CONDITION
CREATE TABLE mart(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

Insert into mart values(10,'Mark','Honda');
Insert into mart values(20,'John','Toyota');
Insert into mart values(30,'Amy','Ford');
Insert into mart values(20,'Mark','Toyota');
Insert into mart values(10,'Adam','Honda');
Insert into mart values(40,'Mark','Hyundai');
Insert into mart values(20,'Eddie','Toyota');

CREATE TABLE nisan(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

Insert into nisan values(10,'Hasan','Honda');
Insert into nisan values(10,'Kemal','Honda');
Insert into nisan values(20,'Ayse','Toyota');
Insert into nisan values(50,'Yasar','Volvo');
Insert into nisan values(20,'Mine','Toyota');

select*from mart;
select*from nisan;

--Mart ve Nisan aylarinda ayni urun_id ile satilan urunlerin urun_id'lerini listeleyen ve ayni zamanda
--bu urunleri NİSAN ayinda alan Musteri_İsim'lerini listeleyen bir sorgu yapiniz.

Select urun_id,musteri_isim from nisan where Exists(select urun_id from mart where mart.urun_id=nisan.urun_id)

	--DML -->	UPDATE

CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler2 -- child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler2 FOREIGN KEY(ted_vergino) 
REFERENCES tedarikciler(vergi_no)
on delete cascade
); 
INSERT INTO urunler2 VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler2 VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler2 VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler2 VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler2 VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler2 VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler2 VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

SELECT*FROM tedarikciler
SELECT*FROM urunler2

-- Vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
UPDATE tedarikciler
SET firma_ismi='Vestel' where vergi_no=102;

-- Vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
update tedarikciler
set firma_ismi='Casper',irtibat_ismi='Ali Veli' where vergi_no=101;

-- urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
update urunler2
set urun_isim='Telefon' where urun_isim='Phone';

-- urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
update urunler2
set urun_id=urun_id+1 where urun_id>1004;
select*from urunler2

--Urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak 
--güncelleyiniz.
update urunler2
set urun_id=urun_id+ted_vergino 

Delete from tedarikciler
delete from urunler2

CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler2 -- child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler2 FOREIGN KEY(ted_vergino) 
REFERENCES tedarikciler(vergi_no)
on delete cascade
); 
INSERT INTO urunler2 VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler2 VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler2 VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler2 VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler2 VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler2 VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler2 VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

select*from urunler2
select*from tedarikciler

--Urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi 
--'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.
update urunler2
set urun_isim=(Select firma_ismi from tedarikciler where irtibat_ismi='Adam Eve')
where musteri_isim='Ali Bak';

-- Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile degistirin.
update urunler2
set musteri_isim=(Select irtibat_ismi from tedarikciler where firma_ismi='Apple')
where urun_isim='Laptop';