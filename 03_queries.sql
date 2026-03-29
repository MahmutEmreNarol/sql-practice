-- ============================================================
-- ŞEMA 1: SORGULAR
-- ============================================================


-- ------------------------------------------------------------
-- 1. Her öğretim üyesinin verdiği ders sayısı
-- ------------------------------------------------------------
SELECT
    ou.ad,
    ou.soyad,
    COUNT(d.ders_kodu) AS ders_sayisi
FROM Ogretim_Uyesi ou
JOIN Ders d ON ou.sicil_no = d.ogretim_uyesi_sicil
GROUP BY ou.sicil_no, ou.ad, ou.soyad;


-- ------------------------------------------------------------
-- 2. En az 3 derse kayıtlı öğrenciler
-- ------------------------------------------------------------
SELECT
    o.ogr_no,
    o.ad,
    o.soyad,
    o.dogum_tarihi,
    o.cinsiyet,
    o.bolum_kodu,
    COUNT(k.ders_kodu) AS ders_adedi
FROM Ogrenciler o
JOIN Kayit k ON o.ogr_no = k.ogr_no
GROUP BY o.ogr_no, o.ad, o.soyad, o.dogum_tarihi, o.cinsiyet, o.bolum_kodu
HAVING COUNT(k.ders_kodu) >= 3;


-- ------------------------------------------------------------
-- 3. Bölüm ve cinsiyete göre öğrenci sayısı
-- ------------------------------------------------------------
SELECT
    o.bolum_kodu,
    o.cinsiyet,
    COUNT(*) AS sayi
FROM Ogrenciler o
GROUP BY o.bolum_kodu, o.cinsiyet;


-- ------------------------------------------------------------
-- 4. Final ortalaması en yüksek ilk 3 ders
-- ------------------------------------------------------------
SELECT
    ders_kodu,
    AVG(final_notu) AS ortalama_final
FROM Kayit
GROUP BY ders_kodu
ORDER BY ortalama_final DESC
LIMIT 3;


-- ------------------------------------------------------------
-- 5. AA harf notu alan öğrenciler
-- ------------------------------------------------------------
SELECT
    o.ogr_no,
    o.ad,
    o.soyad,
    k.harf_notu
FROM Ogrenciler o
JOIN Kayit k ON o.ogr_no = k.ogr_no
WHERE k.harf_notu = 'AA';


-- ------------------------------------------------------------
-- 6. Hiç derse kaydolmamış öğrenciler (NOT IN ile)
-- ------------------------------------------------------------
SELECT ogr_no, ad, soyad
FROM Ogrenciler
WHERE ogr_no NOT IN (SELECT ogr_no FROM Kayit);


-- ------------------------------------------------------------
-- 7. Öğretim üyesi atanmamış dersler (NULL kontrolü)
-- ------------------------------------------------------------
SELECT *
FROM Ders
WHERE ogretim_uyesi_sicil IS NULL;


-- ------------------------------------------------------------
-- 8. Vize %40 + Final %60 formülüyle hesaplanan harf notu
-- ------------------------------------------------------------
SELECT
    o.ogr_no,
    o.ad,
    o.soyad,
    ROUND(k.vize * 0.40 + k.final_notu * 0.60, 2) AS ortalama,
    CASE
        WHEN k.vize * 0.40 + k.final_notu * 0.60 >= 90 THEN 'AA'
        WHEN k.vize * 0.40 + k.final_notu * 0.60 >= 80 THEN 'BA'
        WHEN k.vize * 0.40 + k.final_notu * 0.60 >= 70 THEN 'BB'
        WHEN k.vize * 0.40 + k.final_notu * 0.60 >= 60 THEN 'CB'
        WHEN k.vize * 0.40 + k.final_notu * 0.60 >= 50 THEN 'CC'
        WHEN k.vize * 0.40 + k.final_notu * 0.60 >= 45 THEN 'DC'
        WHEN k.vize * 0.40 + k.final_notu * 0.60 >= 40 THEN 'DD'
        ELSE 'FF'
    END AS hesaplanan_harf
FROM Ogrenciler o
JOIN Kayit k ON k.ogr_no = o.ogr_no;


-- ------------------------------------------------------------
-- 9. 2003 yılında doğan öğrenciler (tarih aralığı)
-- ------------------------------------------------------------
SELECT ad, soyad, dogum_tarihi
FROM Ogrenciler
WHERE dogum_tarihi BETWEEN '2003-01-01' AND '2004-01-01';


-- ------------------------------------------------------------
-- 10. Vizesi 80'den yüksek kayıtlar (derse göre sıralı)
-- ------------------------------------------------------------
SELECT ders_kodu, vize
FROM Kayit
WHERE vize > 80
ORDER BY ders_kodu;


-- ------------------------------------------------------------
-- 11. BM101 dersine kayıtlı öğrenciler ve vizeleri
-- ------------------------------------------------------------
SELECT
    o.ogr_no,
    o.ad,
    o.soyad,
    k.vize
FROM Ogrenciler o
JOIN Kayit k ON o.ogr_no = k.ogr_no
WHERE k.ders_kodu = 'BM101';


-- ------------------------------------------------------------
-- 12. Tüm öğrenciler ve varsa kayıtlı oldukları dersler (LEFT JOIN)
-- ------------------------------------------------------------
SELECT
    o.ogr_no,
    o.ad,
    o.soyad,
    k.ders_kodu
FROM Ogrenciler o
LEFT JOIN Kayit k ON o.ogr_no = k.ogr_no;


-- ------------------------------------------------------------
-- 13. BM bölümündeki öğretim üyelerinin derslerindeki öğrenci sayısı
-- ------------------------------------------------------------
SELECT
    ou.sicil_no,
    ou.ad,
    ou.soyad,
    d.ders_kodu,
    COUNT(k.ogr_no) AS ogrenci_sayisi
FROM Ogretim_Uyesi ou
JOIN Ders d ON d.ogretim_uyesi_sicil = ou.sicil_no
JOIN Kayit k ON d.ders_kodu = k.ders_kodu
WHERE ou.bolum_kodu = 'BM'
GROUP BY k.ders_kodu, ou.sicil_no, ou.ad, ou.soyad;


-- ------------------------------------------------------------
-- 14. Unvan ve bölüme göre ortalama maaş
-- ------------------------------------------------------------
SELECT
    unvan,
    bolum_kodu,
    AVG(maas) AS ortalama_maas
FROM Ogretim_Uyesi
GROUP BY unvan, bolum_kodu;


-- ------------------------------------------------------------
-- 15. Bölüm ve unvana göre ortalama final notu
-- ------------------------------------------------------------
SELECT
    ou.bolum_kodu,
    ou.unvan,
    AVG(k.final_notu) AS final_ortalamasi
FROM Ogretim_Uyesi ou
JOIN Ders d ON ou.sicil_no = d.ogretim_uyesi_sicil
JOIN Kayit k ON d.ders_kodu = k.ders_kodu
GROUP BY ou.bolum_kodu, ou.unvan;


-- ------------------------------------------------------------
-- 16. Aynı bölüm ve unvana sahip öğretim üyesi çiftleri (Self Join)
-- ------------------------------------------------------------
SELECT
    o.ad  AS hoca_1,
    u.ad  AS hoca_2,
    o.unvan        AS ortak_unvan,
    o.bolum_kodu   AS ortak_bolum
FROM Ogretim_Uyesi o
JOIN Ogretim_Uyesi u
    ON  o.bolum_kodu = u.bolum_kodu
    AND o.unvan      = u.unvan
WHERE o.sicil_no < u.sicil_no;
