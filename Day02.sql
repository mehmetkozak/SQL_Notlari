CREATE TABLE ogrenciler1
(
ogrenci_no char(7),--uzunluğu bilinen Stringler için Char kullanılır
isim varchar(20),--uzunluğu bilmediğimiz Stringler için Varchar kullanılır
soyisim varchar(25),
not_ort real, --Ondalikli sayilar kullanilir (Double gibi)
kayit_tarih date);

--VAR OLAN BİR TABLODAN YENİ BİR TABLO OLUŞTURMA
Create table NOTLAR
as
Select isim,not_ort From ogrenciler1;

select *From notlar;

--ıNSERT-TABLO İÇİNE VERİ EKLEME

INSERT INTO notlar Values ('Mehmet',100);

--CONSTRAİNT

--1) UNIQUE

CREATE TABLE ogrenciler2
(
ogrenci_no char(7) UNIQUE,--Tekrarsız field eklemek için UNIQUE kullanılır
isim varchar(20) NOT NULL,--Null değer eklememek için NOT NULL kullanılır
soyisim varchar(25),
not_ort real, --Ondalikli sayilar kullanilir (Double gibi)
kayit_tarih date);

SELECT *FROM OGRENCILER2

Insert Into ogrenciler2 values('1234567','Mehmet','Kozak',75.5,now());
Insert Into ogrenciler2 values('1234568','Ali','Veli',75.5,now());
Insert Into ogrenciler2 (ogrenci_no,soyisim,not_ort) values ('1234569','Kozak',85.5)--Not null kısıtlaması olduğu için bu veri eklenemez

--Primary Key ataması
CREATE TABLE ogrenciler3
(
ogrenci_no char(7) primary key,
isim varchar(20),
soyisim varchar(25),
not_ort real, 
kayit_tarih date);

--Primary key ataması 2. yol
CREATE TABLE ogrenciler4
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real, 
kayit_tarih date,
Constraint ogr Primary Key (ogrenci_no)
);

--FOEİGN KEY
/*
Practice 4:
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/

CREATE TABLE tedarikciler3
(
tedarikci_id char(5) PRIMARY KEY,
tedarikci_ismi varchar(20),
iletisim_isim varchar(20)
);

CREATE TABLE urunler
(
tedarikci_id char(5),
urun_id char(5),
FOREIGN KEY(tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);

select*from tedarikciler3;

/* Practice
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari olsun.
“id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve “sehir” fieldlari olsun. 
“adres_id” field‘i ile Foreign Key oluşturun.
*/
Create table calisanlar(
id varchar(15) Primary key,
isim varchar(30) unique,
maas int not null,	
ise_baslama	date
);

create table adresler(
adres_id varchar(30),
sokak varchar(30),	
cadde varchar(30),
sehir varchar(30),	
Foreign key (adres_id) references calisanlar(id)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14');--Unique cons. olduğu için kabul etmedi
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');--Not null cons. olduğu için kabul etmedi
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');--Unique cons. olduğu için kabul etmedi
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');--ınt dedin string giremezsin olduğu için kabul etmedi
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');--primary key  olduğu 2. hiçliği için kabul etmedi
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--primary key  olduğu 2. no için kabul etmedi
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');--primary key null değer kabul etmez

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');--Parent table'da 10012 id no olmadığı chiçin kabul etmedi

-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

select*from calisanlar;
select*from adresler;

--Check cons.
Create table calisanlar1(
id varchar(15) Primary key,
isim varchar(30) unique,
maas int Check(maas>10000),	
ise_baslama	date
);

INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10003', 'Mehmet Kozak' ,9000, '2018-04-14');--maas check cons. 10 binden fazla olsun demiştik 
select*from calisanlar1;

--DQL --WHERE KULLANIMI

SELECT*FROM calisanlar;
SELECT isim From calisanlar;

--Calısanlar tablosundan maaşı 5000 den büyük olan isimleri listeleyiniz
select isim,maas from calisanlar where maas>5000;

--Calısanlar tablosundan ismi Veli Han olan tüm verileri  listeleyiniz
select*From calisanlar where isim='Veli Han';

--Calısanlar tablosundan maaşı 5000  olan tüm verileri  listeleyiniz
select*From calisanlar where maas=5000;

--DmL --DELETE KOMUTU KULLANIMI

DELETE FROM calisanlar;--parent tablo başka bir tablo child tablo ile ilişkili ise önce child  tablo silinmelidir
Delete from adresler;--tablonun içindeki veriler silinir. tablonun kendisi silinmez

--Yeniden adresler tablosuna veriler ekledik
delete from adresler where sehir ='Antep';--sehir antep olanları sildik
select*from adresler;

CREATE TABLE ogrenciler5
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler5 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler5 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler5 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler5 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler5 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler5 VALUES(127, 'Mustafa Bak', 'Ali', 99);

--Example 1) ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.




