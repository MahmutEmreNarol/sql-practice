-- ============================================================
-- ŞEMA 1: TEST VERİLERİ
-- ============================================================

INSERT INTO Bolum (bolum_kodu, bolum_adi, bina) VALUES
    ('BM',  'Bilgisayar Mühendisliği',  'Müh. A'),
    ('EE',  'Elektrik-Elektronik Müh',  'Müh. B'),
    ('END', 'Endüstri Mühendisliği',    'Müh. C');

INSERT INTO Ogretim_Uyesi (sicil_no, ad, soyad, unvan, maas, bolum_kodu) VALUES
    (101, 'Ahmet',  'Yılmaz', 'Prof. Dr.',      35000, 'BM'),
    (102, 'Ayşe',   'Demir',  'Doç. Dr.',       28000, 'BM'),
    (103, 'Mehmet', 'Kaya',   'Dr. Öğr. Üy.',   22000, 'EE'),
    (104, 'Fatma',  'Aksoy',  'Prof. Dr.',       34000, 'EE'),
    (105, 'Ali',    'Çelik',  'Arş. Gör.',       12000, 'BM'),
    (106, 'Zeynep', 'Şahin',  'Prof. Dr.',       33000, 'BM');

INSERT INTO Ders (ders_kodu, ders_adi, kredi, ogretim_uyesi_sicil) VALUES
    ('BM101',  'Programlamaya Giriş',    4, 102),
    ('BM201',  'Veri Yapıları',          4, 101),
    ('BM301',  'Veri Tabanı Yön. Sis.',  3, 101),
    ('EE101',  'Devre Analizi',          4, 103),
    ('EE201',  'Sinyal ve Sistemler',    3, 104),
    ('END101', 'Yöneylem Araştırması',   3, NULL);  -- Hoca atanmamış

INSERT INTO Ogrenciler (ogr_no, ad, soyad, dogum_tarihi, cinsiyet, bolum_kodu) VALUES
    (1001, 'Cem',    'Arslan',   '2003-05-15', 'E', 'BM'),
    (1002, 'Elif',   'Koç',      '2002-11-20', 'K', 'BM'),
    (1003, 'Burak',  'Yıldız',   '2003-08-03', 'E', 'EE'),
    (1004, 'Selin',  'Aydın',    '2004-01-22', 'K', 'EE'),
    (1005, 'Emre',   'Güneş',    '2003-03-10', 'E', 'BM'),
    (1006, 'Zeynep', 'Kara',     '2002-07-18', 'K', 'END'),
    (1007, 'Can',    'Yıldırım', '2004-09-25', 'E', 'END'),
    (1008, 'Test',   'Kişi',     '2003-01-01', 'E', 'BM');  -- Hiç derse kaydolmamış

INSERT INTO Kayit (ogr_no, ders_kodu, kayit_tarihi, vize, final_notu, harf_notu) VALUES
    (1001, 'BM101', '2025-09-15', 85,   90,   'AA'),
    (1001, 'BM201', '2025-09-15', 70,   65,   'CB'),
    (1001, 'BM301', '2025-09-15', 55,   48,   'DC'),
    (1002, 'BM101', '2025-09-15', 92,   88,   'AA'),
    (1002, 'BM301', '2025-09-15', 78,   82,   'BA'),
    (1003, 'EE101', '2025-09-16', 60,   55,   'CC'),
    (1003, 'BM101', '2025-09-16', 45,   38,   'FF'),
    (1004, 'EE101', '2025-09-16', 88,   92,   'AA'),
    (1004, 'EE201', '2025-09-16', 75,   70,   'CB'),
    (1005, 'BM201', '2025-09-15', 65,   72,   'CB'),
    (1005, 'BM301', '2025-09-15', NULL, NULL, NULL),  -- Not girilmemiş
    (1006, 'END101','2025-09-17', 50,   45,   'DD'),
    (1007, 'END101','2025-09-17', 80,   85,   'BA');
