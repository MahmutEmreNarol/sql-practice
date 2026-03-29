-- ============================================================
-- ŞEMA 1: ÜNİVERSİTE YÖNETİM SİSTEMİ
-- Tablolar: Bolum, Ogretim_Uyesi, Ders, Ogrenciler, Kayit
-- ============================================================

CREATE TABLE Bolum (
    bolum_kodu VARCHAR(10) PRIMARY KEY,
    bolum_adi  VARCHAR(100) NOT NULL,
    bina       VARCHAR(50)
);

CREATE TABLE Ogretim_Uyesi (
    sicil_no    INT PRIMARY KEY,
    ad          VARCHAR(50) NOT NULL,
    soyad       VARCHAR(50) NOT NULL,
    unvan       VARCHAR(30),
    maas        DECIMAL(10,2) CHECK(maas > 0),
    bolum_kodu  VARCHAR(10)
);

CREATE TABLE Ders (
    ders_kodu           VARCHAR(10) PRIMARY KEY,
    ders_adi            VARCHAR(100) NOT NULL,
    kredi               INT CHECK(kredi BETWEEN 1 AND 8),
    ogretim_uyesi_sicil INT
);

CREATE TABLE Ogrenciler (
    ogr_no        INT PRIMARY KEY,
    ad            VARCHAR(50) NOT NULL,
    soyad         VARCHAR(50) NOT NULL,
    dogum_tarihi  DATE,
    cinsiyet      CHAR CHECK(cinsiyet = 'E' OR cinsiyet = 'K') NOT NULL,
    bolum_kodu    VARCHAR(10) NOT NULL
);

CREATE TABLE Kayit (
    ogr_no       INT,
    ders_kodu    VARCHAR(10),
    kayit_tarihi DATE,
    vize         DECIMAL(5,2) CHECK(vize BETWEEN 0 AND 100),
    final_notu   DECIMAL(5,2) CHECK(final_notu BETWEEN 0 AND 100),
    harf_notu    VARCHAR(2),
    PRIMARY KEY (ogr_no, ders_kodu)
);
