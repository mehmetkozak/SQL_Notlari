--DATABASE(VeriTabani) Olusturma
/*
Create database murat;
create database aydin;
*/

--DDL - DATA DEFINITTON LANG.
--CREATE - TABLO OLUSTURMA
CREATE TABLE ogrenciler1
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real, --Ondalikli sayilar kullanilir (Double gibi)
kayit_tarih date
);

--Var olan Tablodan yeni bir tablo oluşturma
Create table ogrenci_notlari
as --Benzer tablodaki başlıklarla ve data typleri ile yeni bir tablo oluşturmak için normal tablo oluştururken ki
--parantezler yerine "as" kullanıp Select komutuyla istediğimiz başlıkları alabiliriz
select isim,soyisim,not_ort From ogrenciler;

--DML-Data Manipulation Lang.
--INSERT(database veri ekleme)

Insert Into ogrenciler Values('1234567','Said','ILHAN',85.5,now());
Insert Into ogrenciler Values('1234567','Said','ILHAN',85.5,'2022-12-11';
							  
--Parçalı veri eklemek istersek
Insert Into ogrenciler(isim,soyisim)values ('Mehmet','KOZAK');
							  
--DQL -Data Query Lang.
--Select
Select*FROM ogrenciler;						