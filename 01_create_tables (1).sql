-- ============================================================
-- ŞEMA 2: BÖLÜMLER / DERSLER / KAYITLAR SİSTEMİ
-- Tablolar: Bolumler, Ogrenciler, Ogretim_Uyeleri, Dersler, Kayitlar
-- ============================================================

CREATE TABLE Bolumler (
    bolum_id  INT PRIMARY KEY,
    bolum_adi VARCHAR(50)
);

CREATE TABLE Ogretim_Uyeleri (
    ogretim_uyesi_id INT PRIMARY KEY,
    ad               VARCHAR(50),
    soyad            VARCHAR(50),
    bolum_id         INT,
    FOREIGN KEY (bolum_id) REFERENCES Bolumler(bolum_id)
);

CREATE TABLE Dersler (
    ders_id          INT PRIMARY KEY,
    ders_adi         VARCHAR(50),
    ogretim_uyesi_id INT,
    FOREIGN KEY (ogretim_uyesi_id) REFERENCES Ogretim_Uyeleri(ogretim_uyesi_id)
);

CREATE TABLE Ogrenciler (
    ogrenci_id INT PRIMARY KEY,
    ad         VARCHAR(50),
    soyad      VARCHAR(50),
    bolum_id   INT,
    FOREIGN KEY (bolum_id) REFERENCES Bolumler(bolum_id)
);

CREATE TABLE Kayitlar (
    kayit_id   INT PRIMARY KEY,
    ogrenci_id INT,
    ders_id    INT,
    notu       INT,
    FOREIGN KEY (ogrenci_id) REFERENCES Ogrenciler(ogrenci_id),
    FOREIGN KEY (ders_id)    REFERENCES Dersler(ders_id)
);
