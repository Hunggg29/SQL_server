CREATE TABLE GiangVien(
  MaGV char(4) NOT NULL,
  HoTen nchar(30) NOT NULL,
  DiaChi nvarchar(50) NOT NULL,
  NgaySinh date NOT NULL,
  CONSTRAINT KhoaChinhGiangVien PRIMARY KEY (MaGV)
)

CREATE TABLE DeTai(
  MaDT char(4) NOT NULL,
  TenDT nvarchar(50) NOT NULL,
  Cap nchar(12) NOT NULL,
  KinhPhi integer,
  CONSTRAINT KhoaChinhDeTai PRIMARY KEY (MaDT)
)

CREATE TABLE ThamGia(
  MaGV char(4) NOT NULL,
  MaDT char(4) NOT NULL,
  SoGio smallint,
  CONSTRAINT KhoaChinhThamGia PRIMARY KEY (MaGV, MaDT),
  CONSTRAINT KhoaNgoai1 FOREIGN KEY (MaGV) REFERENCES GiangVien (MaGV),
  CONSTRAINT KhoaNgoai2 FOREIGN KEY (MaDT) REFERENCES DeTai (MaDT) 
)


INSERT INTO GiangVien VALUES('GV01',N'Vũ Tuyết Trinh',N'Hoàng Mai, Hà Nội','1975/10/10'),
('GV02',N'Nguyễn Nhật Quang',N'Hai Bà Trưng, Hà Nội','1976/11/03'),
('GV03',N'Trần Đức Khánh',N'Đống Đa, Hà Nội','1977/06/04'),
('GV04',N'Nguyễn Hồng Phương',N'Tây Hồ, Hà Nội','1983/12/10'),
('GV05',N'Lê Thanh Hương',N'Hai Bà Trưng, Hà Nội','1976/10/10')

select *
from GiangVien 
Where DiaChi = 'Hai Bà Trưng, Hà Nội';

INSERT INTO DeTai VALUES ('DT01',N'Tính toán lưới',N'Nhà nước','700'),
('DT02',N'Phát hiện tri thức',N'Bộ','300'),
('DT03',N'Phân loại văn bản',N'Bộ','270'),
('DT04',N'Dịch tự động Anh Việt',N'Trường','30')


INSERT INTO ThamGia VALUES ('GV01','DT01','100'),
('GV01','DT02','80'),
('GV01','DT03','80'),
('GV02','DT01','120'),
('GV02','DT03','140'),
('GV03','DT03','150'),
('GV04','DT04','180')



select *
from GiangVien
Where DiaChi LIKE N'Hai Bà Trưng%';

select g.HoTen, g.DiaChi, g.NgaySinh
from DeTai d, GiangVien g, ThamGia t
Where g.MaGV = t.MaGV AND t.MaDT = d.MaDT AND d.MaDT = 'DT01';

select TOP 1 HoTen, COUNT(t.MaGV)
From GiangVien g , ThamGia t 
Where g.MaGV = t.MaGV
Group by HoTen
Order by COUNT(t.MaGV) DESC;

select  TOP 1 d.TenDT, SUM(t.SoGio *  d.KinhPhi) AS Tongchiphi
from ThamGia t , DeTai d
Where t.MaDT = d.MaDT
Group by d.TenDT
Order by Tongchiphi;

select g.HoTen, g.DiaChi, d.TenDT, g.NgaySinh
from GiangVien g, DeTai d, ThamGia t
Where g.MaGV = t.MaGV AND t.MaDT = d.MaDT AND g.NgaySinh < '1/1/1980' AND d.TenDT = N'Phân loại văn bản';

select g.MaGV, g.HoTen, SUM(SoGio)
from GiangVien g, ThamGia t
Where g.MaGV = t.MaGV
Group by g.MaGV, g.HoTen;

