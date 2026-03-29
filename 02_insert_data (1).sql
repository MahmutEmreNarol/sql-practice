-- ============================================================
-- ŞEMA 2: TEST VERİLERİ
-- ============================================================

INSERT INTO Bolumler (bolum_id, bolum_adi) VALUES
    (1, 'Bilgisayar Mühendisliği'),
    (2, 'Elektronik Mühendisliği');

INSERT INTO Ogretim_Uyeleri (ogretim_uyesi_id, ad, soyad, bolum_id) VALUES
    (1, 'Ahmet', 'Bilir', 1),
    (2, 'Ayşe',  'Görür', 2);

INSERT INTO Dersler (ders_id, ders_adi, ogretim_uyesi_id) VALUES
    (1, 'Yapay Zeka',    1),
    (2, 'Programlama',   1),
    (3, 'Lojik Tasarım', 2);

INSERT INTO Ogrenciler (ogrenci_id, ad, soyad, bolum_id) VALUES
    (1, 'Tufan', 'Akkara', 1),
    (2, 'Fatma', 'Karaak', 1),
    (3, 'Hakan', 'Ak',     2);

-- (kayit_id, ogrenci_id, ders_id, notu)
INSERT INTO Kayitlar (kayit_id, ogrenci_id, ders_id, notu) VALUES
    (1, 1, 1, 80),  -- Tufan  → Yapay Zeka
    (2, 1, 2, 90),  -- Tufan  → Programlama
    (3, 2, 2, 50),  -- Fatma  → Programlama
    (4, 2, 3, 75),  -- Fatma  → Lojik Tasarım
    (5, 3, 3, 80),  -- Hakan  → Lojik Tasarım
    (6, 3, 1, 40);  -- Hakan  → Yapay Zeka
