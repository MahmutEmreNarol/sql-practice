-- ============================================================
-- ŞEMA 2: SORGULAR
-- ============================================================


-- ------------------------------------------------------------
-- 1. Her öğretim üyesinin verdiği dersler
-- ------------------------------------------------------------
SELECT
    ou.ogretim_uyesi_id,
    ou.ad,
    ou.soyad,
    d.ders_adi
FROM Ogretim_Uyeleri ou
JOIN Dersler d ON ou.ogretim_uyesi_id = d.ogretim_uyesi_id;


-- ------------------------------------------------------------
-- 2. Belirli bir öğrencinin aldığı ders ve notu (kayit_id = 1)
-- ------------------------------------------------------------
SELECT
    k.kayit_id,
    d.ders_adi,
    k.notu
FROM Kayitlar k
JOIN Dersler d ON k.ders_id = d.ders_id
WHERE k.kayit_id = 1;


-- ------------------------------------------------------------
-- 3. Bölümlere göre öğrenci sayısı
-- ------------------------------------------------------------
SELECT
    b.bolum_adi,
    COUNT(o.ogrenci_id) AS ogrenci_adedi
FROM Bolumler b
JOIN Ogrenciler o ON b.bolum_id = o.bolum_id
GROUP BY b.bolum_adi;


-- ------------------------------------------------------------
-- 4. Not ortalaması 50'nin üzerinde olan öğrenciler
-- ------------------------------------------------------------
SELECT
    o.ad,
    o.soyad,
    AVG(k.notu) AS ortalama_not
FROM Ogrenciler o
JOIN Kayitlar k ON k.ogrenci_id = o.ogrenci_id
GROUP BY o.ogrenci_id, o.ad, o.soyad
HAVING AVG(k.notu) > 50;


-- ------------------------------------------------------------
-- 5. Not ortalaması 60'ın üzerinde olan bölümler
-- ------------------------------------------------------------
SELECT
    b.bolum_adi,
    AVG(k.notu) AS genel_ortalama
FROM Bolumler b
JOIN Ogrenciler o ON b.bolum_id = o.bolum_id
JOIN Kayitlar k   ON o.ogrenci_id = k.ogrenci_id
GROUP BY b.bolum_adi
HAVING AVG(k.notu) > 60;


-- ------------------------------------------------------------
-- 6. Genel ortalamanın altında kalan öğretim üyeleri (Subquery)
-- ------------------------------------------------------------
SELECT
    ou.ad,
    ou.soyad,
    AVG(k.notu) AS hoca_ortalamasi
FROM Ogretim_Uyeleri ou
JOIN Dersler d  ON d.ogretim_uyesi_id = ou.ogretim_uyesi_id
JOIN Kayitlar k ON k.ders_id = d.ders_id
GROUP BY ou.ad, ou.soyad
HAVING AVG(k.notu) < (SELECT AVG(notu) FROM Kayitlar);


-- ------------------------------------------------------------
-- 7. Kendi bölümünden farklı bölümün hocasının dersine kayıtlı öğrenciler
-- ------------------------------------------------------------
SELECT
    o.ad,
    o.soyad,
    d.ders_adi
FROM Ogrenciler o
JOIN Kayitlar k        ON k.ogrenci_id = o.ogrenci_id
JOIN Dersler d         ON k.ders_id = d.ders_id
JOIN Ogretim_Uyeleri ou ON d.ogretim_uyesi_id = ou.ogretim_uyesi_id
WHERE o.bolum_id <> ou.bolum_id;
