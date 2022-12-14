--GROUP BY

CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

delete from personel

SELECT*FROM PERSONEL

--1)Isme gore toplam maaslari bulun
Select isim,sum(maas) from personel group by isim;

--2)sehre gore toplam personel sayisini bulun
Select sehir,count(isim) from personel group by sehir;

--3)Sirketlere gore maasi 5000 liradan fazla olan personel sayisini bulun
select sirket,count(*) from personel where maas>5000 group by sirket;

			--HAVİNG CLAUSE
--Aggregate function'larla birlikte kullanılan FİLTRELEME komutudur.
/*
Having komutu yalnızca group by komutu ile kullanılır.Eğer gruplamadan sonra bir şart
varsa  Having komutu kuulanılır. Where kullanımı ile aynı mantıkta çalışır
*/

--1) Her sirketin MIN maaslarini eger 4000’den buyukse goster

select sirket,min(maas) as en_dusuk_maas from personel 
group by sirket having min(maas)>4000

-- 2) Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi
-- ve toplam maasi gosteren sorgu yaziniz

Select isim,sum(maas) from personel group by isim having sum(maas)>10000

--3) Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz

Select sehir,count(isim) from personel group by sehir having count(isim)>1

-- 4) Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz

Select sehir,max(maas) from personel group by sehir having max(maas)<5000

			--UNION OPERATOR
/*
Iki farkli sorgulamanin sonucunu birlestiren islemdir. Secilen Field SAYISI ve DATA TYPE’i ayni 
olmalidir.
*/
select*from personel
-- 1) Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan sehirleri gosteren sorguyu yaziniz

SELECT isim,maas from personel where maas>4000
Union
Select sehir,maas from personel where maas>5000

-- 2) Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini bir tabloda gosteren sorgu yaziniz

Select sehir,maas from personel where sehir='Istanbul'
union
select isim,maas from personel where isim='Mehmet Ozturk'

-- 								UNION OPERATOR
-- 						2 Tablodan Data Birlestirme

drop table if exists personel

CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

CREATE TABLE personel_bilgi  
(
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int
);
INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

select * from personel
select * from personel_bilgi

-- 1) id’si 123456789 olan personelin    Personel tablosundan sehir ve maasini, 
-- personel_bilgi  tablosundan da tel ve cocuk sayisini yazdirin

Select sehir,maas from personel where id=123456789
union
select tel,cocuk_sayisi from personel_bilgi where id=123456789

/*
UNION islemi 2 veya daha cok SELECT isleminin sonuc KUMELERINI birlestirmek icin kullanilir,
Ayni kayit birden fazla olursa, sadece bir tanesini alir. UNION ALL ise tekrarli elemanlari, tekrar sayisinca yazar.
*/

--2) Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz
Select isim,maas from personel where maas<5000
UNION aLL
Select isim,maas from personel where maas<5000

				-- INTERSECT (Kesişim) OPERATOR
/*
Farkli iki tablodaki ortak verileri INTERSECT komutu ile getirebiliriz
*/
--1) Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
select id from personel where sehir in ('Istanbul','Ankara')
--2) Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
select id FROM personel_bilgi where cocuk_sayisi in(2,3)
--3) şimdi 1 ve 2 nolu sorguların INTERSECT ile kesişimlerini bulun
select id from personel where sehir in ('Istanbul','Ankara')
intersect
select id FROM personel_bilgi where cocuk_sayisi in(2,3)

--4) Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
select*from personel
select isim from personel where sirket='Honda'
intersect
select isim from personel where sirket='Tofas'
intersect
select isim from personel where sirket='Ford'

			--EXCEPT OPERATOR
/*
iki sorgulamada harici bir sorgulama istenirse EXCEPT komutu kullanilir
*/
--5000’den az maas alip Honda’da calismayanlari yazdirin
select isim,sirket from personel where maas<5000
except
select isim,sirket from personel where sirket='Honda'
