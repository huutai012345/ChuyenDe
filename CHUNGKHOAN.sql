USE [CHUNGKHOAN]
GO
/****** Object:  Table [dbo].[LENHKHOP]    Script Date: 25/05/2021 09:09:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LENHKHOP](
	[IDKHOP] [int] IDENTITY(1,1) NOT NULL,
	[NGAYKHOP] [datetime] NULL,
	[SOLUONGKHOP] [int] NULL,
	[GIAKHOP] [float] NULL,
	[IDLENHDAT] [int] NULL,
 CONSTRAINT [PK_LENHKHOP] PRIMARY KEY CLUSTERED 
(
	[IDKHOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LENHDAT]    Script Date: 25/05/2021 09:09:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LENHDAT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MACP] [nchar](7) NULL,
	[NGAYDAT] [datetime] NULL,
	[LOAIGD] [nchar](1) NULL,
	[LOAILENH] [nchar](3) NULL,
	[SOLUONG] [int] NULL,
	[GIADAT] [float] NULL,
	[TRANGTHAILENH] [nvarchar](50) NULL,
 CONSTRAINT [PK_LENHDAT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TABLE1]    Script Date: 25/05/2021 09:09:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TABLE1]
AS
SELECT LENHDAT.MACP, LENHKHOP.GIAKHOP, SUM(SOLUONGKHOP) AS SOLUONG, NGAYKHOP
FROM     LENHKHOP JOIN
                  (SELECT * FROM LENHDAT WHERE LENHDAT.LOAIGD = 'M' AND (TRANGTHAILENH = N'Chờ Khớp' OR
                                         TRANGTHAILENH = N'Khớp lệnh 1 phần' )) LENHDAT ON LENHKHOP.IDLENHDAT = LENHDAT.ID JOIN
                      (SELECT MACP, MAX(GIAKHOP) AS GIAKHOP
                       FROM      LENHKHOP JOIN
                                         LENHDAT ON LENHKHOP.IDLENHDAT = LENHDAT.ID
                       WHERE   LENHDAT.LOAIGD = 'M' AND (TRANGTHAILENH = N'Chờ Khớp' OR
                                         TRANGTHAILENH = N'Khớp lệnh 1 phần')
                       GROUP BY MACP) LKM ON LKM.GIAKHOP = LENHKHOP.GIAKHOP AND LKM.MACP = LENHDAT.MACP
GROUP BY LENHDAT.MACP, LENHKHOP.GIAKHOP, NGAYKHOP
UNION
SELECT LENHDAT.MACP, LENHKHOP.GIAKHOP, SUM(SOLUONGKHOP) AS SOLUONG, NGAYKHOP
FROM     LENHKHOP JOIN
                   (SELECT * FROM LENHDAT WHERE LENHDAT.LOAIGD = 'B' AND (TRANGTHAILENH = N'Chờ Khớp' OR
                                         TRANGTHAILENH = N'Khớp lệnh 1 phần' )) LENHDAT ON LENHKHOP.IDLENHDAT = LENHDAT.ID JOIN
                      (SELECT MACP, MIN(GIAKHOP) AS GIAKHOP
                       FROM      LENHKHOP JOIN
                                         LENHDAT ON LENHKHOP.IDLENHDAT = LENHDAT.ID
                       WHERE   LENHDAT.LOAIGD = 'B' AND (TRANGTHAILENH = N'Chờ Khớp' OR
                                         TRANGTHAILENH = N'Khớp lệnh 1 phần')
                       GROUP BY MACP) LKB ON LKB.GIAKHOP = LENHKHOP.GIAKHOP AND LKB.MACP = LENHDAT.MACP
GROUP BY LENHDAT.MACP, LENHKHOP.GIAKHOP, NGAYKHOP
GO
/****** Object:  Table [dbo].[BANGGIATRUCTUYEN]    Script Date: 25/05/2021 09:09:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BANGGIATRUCTUYEN](
	[MACP] [nchar](7) NOT NULL,
	[GIAMUA3] [float] NULL,
	[KLM3] [int] NULL,
	[GIAMUA2] [float] NULL,
	[KLM2] [int] NULL,
	[GIAMUA1] [float] NULL,
	[KLM1] [int] NULL,
	[GIAKHOP] [float] NULL,
	[KLKHOP] [int] NULL,
	[GIABAN1] [float] NULL,
	[KLB1] [int] NULL,
	[GIABAN2] [float] NULL,
	[KLB2] [int] NULL,
	[GIABAN3] [float] NULL,
	[KLB3] [int] NULL,
 CONSTRAINT [PK_BANGGIATRUCTUYEN_1] PRIMARY KEY CLUSTERED 
(
	[MACP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BANGGIATRUCTUYEN] ([MACP], [GIAMUA3], [KLM3], [GIAMUA2], [KLM2], [GIAMUA1], [KLM1], [GIAKHOP], [KLKHOP], [GIABAN1], [KLB1], [GIABAN2], [KLB2], [GIABAN3], [KLB3]) VALUES (N'ACB    ', NULL, NULL, 10000, 1000, 10500, 1000, 10800, 1500, 10800, 500, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[LENHDAT] ON 

INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (2069, N'ACB    ', CAST(N'2021-05-21T14:20:38.867' AS DateTime), N'M', N'LO ', 1000, 10000, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (2070, N'ACB    ', CAST(N'2021-05-21T14:20:50.703' AS DateTime), N'M', N'LO ', 0, 11000, N'Khớp hết')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (2071, N'ACB    ', CAST(N'2021-05-21T14:21:05.770' AS DateTime), N'M', N'LO ', 0, 11000, N'Khớp hết')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (2072, N'ACB    ', CAST(N'2021-05-21T14:21:24.033' AS DateTime), N'M', N'LO ', 1000, 10500, N'Chờ khớp')
INSERT [dbo].[LENHDAT] ([ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH]) VALUES (2073, N'ACB    ', CAST(N'2021-05-21T14:23:43.997' AS DateTime), N'B', N'LO ', 500, 10800, N'Khớp lệnh 1 phần')
SET IDENTITY_INSERT [dbo].[LENHDAT] OFF
GO
SET IDENTITY_INSERT [dbo].[LENHKHOP] ON 

INSERT [dbo].[LENHKHOP] ([IDKHOP], [NGAYKHOP], [SOLUONGKHOP], [GIAKHOP], [IDLENHDAT]) VALUES (2019, CAST(N'2021-05-21T14:21:56.010' AS DateTime), 500, 11000, 2070)
INSERT [dbo].[LENHKHOP] ([IDKHOP], [NGAYKHOP], [SOLUONGKHOP], [GIAKHOP], [IDLENHDAT]) VALUES (2020, CAST(N'2021-05-21T14:23:43.997' AS DateTime), 500, 11000, 2070)
INSERT [dbo].[LENHKHOP] ([IDKHOP], [NGAYKHOP], [SOLUONGKHOP], [GIAKHOP], [IDLENHDAT]) VALUES (2021, CAST(N'2021-05-21T14:23:43.997' AS DateTime), 1000, 11000, 2071)
INSERT [dbo].[LENHKHOP] ([IDKHOP], [NGAYKHOP], [SOLUONGKHOP], [GIAKHOP], [IDLENHDAT]) VALUES (2022, CAST(N'2021-05-21T14:23:43.997' AS DateTime), 1500, 10800, 2073)
SET IDENTITY_INSERT [dbo].[LENHKHOP] OFF
GO
ALTER TABLE [dbo].[LENHDAT] ADD  CONSTRAINT [DF_LENHDAT_NGAYDAT]  DEFAULT (getdate()) FOR [NGAYDAT]
GO
ALTER TABLE [dbo].[LENHDAT] ADD  CONSTRAINT [DF_LENHDAT_LOAILENH]  DEFAULT (N'LO') FOR [LOAILENH]
GO
ALTER TABLE [dbo].[LENHDAT] ADD  CONSTRAINT [DF_LENHDAT_TRANGTHAILENH]  DEFAULT (N'Chờ khớp') FOR [TRANGTHAILENH]
GO
ALTER TABLE [dbo].[LENHKHOP] ADD  CONSTRAINT [DF_LENHKHOP_NGAYKHOP]  DEFAULT (getdate()) FOR [NGAYKHOP]
GO
ALTER TABLE [dbo].[LENHKHOP]  WITH CHECK ADD  CONSTRAINT [FK_LENHKHOP_LENHDAT] FOREIGN KEY([IDLENHDAT])
REFERENCES [dbo].[LENHDAT] ([ID])
GO
ALTER TABLE [dbo].[LENHKHOP] CHECK CONSTRAINT [FK_LENHKHOP_LENHDAT]
GO
/****** Object:  StoredProcedure [dbo].[CursorLoaiGD]    Script Date: 25/05/2021 09:09:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CursorLoaiGD]
  @OutCrsr CURSOR VARYING OUTPUT, 
  @macp NCHAR( 7), @Ngay datetime,  @LoaiGD CHAR 
AS
SET DATEFORMAT DMY 
IF (@LoaiGD='M') 
  SET @OutCrsr=CURSOR KEYSET FOR 
  SELECT ID,NGAYDAT, SOLUONG, GIADAT FROM LENHDAT 
  WHERE MACP=@macp 
    AND DAY(NGAYDAT)=DAY(@Ngay)AND MONTH(NGAYDAT)= MONTH(@Ngay) AND YEAR(NGAYDAT)=YEAR(@Ngay)  
    AND LOAIGD=@LoaiGD AND SOLUONG >0  
	AND (TRANGTHAILENH = N'Chờ Khớp' OR TRANGTHAILENH = N'Khớp lệnh 1 phần')
    ORDER BY GIADAT DESC, NGAYDAT 
ELSE
  SET @OutCrsr=CURSOR KEYSET FOR 
  SELECT ID,NGAYDAT, SOLUONG, GIADAT FROM LENHDAT
  WHERE MACP=@macp 
    AND DAY(NGAYDAT)=DAY(@Ngay)AND MONTH(NGAYDAT)= MONTH(@Ngay) AND YEAR(NGAYDAT)=YEAR(@Ngay)  
    AND LOAIGD=@LoaiGD AND SOLUONG >0  
	AND (TRANGTHAILENH = N'Chờ Khớp' OR TRANGTHAILENH = N'Khớp lệnh 1 phần')
    ORDER BY GIADAT, NGAYDAT 
OPEN @OutCrsr
GO
/****** Object:  StoredProcedure [dbo].[DAT_LENH]    Script Date: 25/05/2021 09:09:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DAT_LENH]
 @macp NCHAR( 7),  @LoaiGD CHAR, 
 @soluongMB INT, @giadatMB FLOAT 
AS
DECLARE @Ngay datetime
SELECT @Ngay=GETDATE()
SET DATEFORMAT DMY
DECLARE @CrsrVar CURSOR , @id INT,@ngaydat NVARCHAR( 50), @soluong INT,@soluonggoc INT, @giadat FLOAT,  @soluongkhop INT, @giakhop FLOAT
SET @soluonggoc = @soluongMB
 IF (@LoaiGD='B')
   EXEC CursorLoaiGD  @CrsrVar OUTPUT, @macp,@Ngay, 'M'
 ELSE 
  EXEC CursorLoaiGD  @CrsrVar OUTPUT, @macp,@Ngay, 'B'
  
FETCH NEXT FROM @CrsrVar  INTO @id, @ngaydat , @soluong , @giadat 
SELECT @id,@ngaydat , @soluong , @giadat
WHILE (@@FETCH_STATUS <> -1 AND @soluongMB >0)
BEGIN
 IF  (@LoaiGD='B' )
   IF  (@giadatMB <= @giadat)
   BEGIN
     IF @soluongMB >= @soluong
     BEGIN
       SET @soluongkhop = @soluong
       SET @giakhop = @giadat
       SET @soluongMB = @soluongMB - @soluong
       UPDATE dbo.LENHDAT  
         SET SOLUONG = 0,TRANGTHAILENH=N'Khớp hết'
         WHERE CURRENT OF @CrsrVar
     END
     ELSE
     BEGIN
       SET @soluongkhop = @soluongMB
       SET @giakhop = @giadat
       
       UPDATE dbo.LENHDAT  
         SET SOLUONG = SOLUONG - @soluongMB,TRANGTHAILENH=N'Khớp lệnh 1 phần'
         WHERE CURRENT OF @CrsrVar
       SET @soluongMB = 0
     END--End cua so sanh so luong
     SELECT  @soluongkhop, @giakhop ,@id
     -- Cập nhật table LENHKHOP
     INSERT INTO dbo.LENHKHOP (SOLUONGKHOP,GIAKHOP,NGAYKHOP,IDLENHDAT) VALUES (@soluongkhop,@giakhop,@Ngay,@id)
   END--so sanh gia
   ELSE
     GOTO THOAT
	
   ELSE--LOAI MUA
   IF  (@giadatMB >= @giadat)
   BEGIN
     IF @soluongMB >= @soluong
     BEGIN
       SET @soluongkhop = @soluong
       SET @giakhop = @giadatMB
       SET @soluongMB = @soluongMB - @soluong
       UPDATE dbo.LENHDAT  
         SET SOLUONG = 0,TRANGTHAILENH=N'Khớp hết'
         WHERE CURRENT OF @CrsrVar
     END
     ELSE
     BEGIN
       SET @soluongkhop = @soluongMB
       SET @giakhop = @giadatMB
       
       UPDATE dbo.LENHDAT  
         SET SOLUONG = SOLUONG - @soluongMB,TRANGTHAILENH=N'Khớp lệnh 1 phần'
         WHERE CURRENT OF @CrsrVar
       SET @soluongMB = 0
     END--End cua so sanh so luong
     SELECT  @soluongkhop, @giakhop ,@id
     -- Cập nhật table LENHKHOP
     INSERT INTO dbo.LENHKHOP (SOLUONGKHOP,NGAYKHOP,GIAKHOP,IDLENHDAT) VALUES (@soluongkhop,@Ngay,@giakhop,@id)
   END--so sanh gia
     ELSE
        GOTO THOAT
	
    
   FETCH NEXT FROM @CrsrVar INTO  @id,@ngaydat , @soluong , @giadat
END
THOAT:
	IF @soluongMB > 0
	BEGIN
		if @soluongMB = @soluonggoc
			insert into dbo.LENHDAT (MACP,LOAIGD,NGAYDAT,SOLUONG,GIADAT,TRANGTHAILENH) values (@macp,@LoaiGD,@Ngay,@soluongMB,@giadatMB,N'Chờ khớp')
		else
		BEGIN
			insert into dbo.LENHDAT (MACP,LOAIGD,NGAYDAT,SOLUONG,GIADAT,TRANGTHAILENH) values (@macp,@LoaiGD,@Ngay,@soluongMB,@giadatMB,N'Khớp lệnh 1 phần')
			DECLARE @IDLENHDAT int;
			SELECT @IDLENHDAT = SCOPE_IDENTITY();
			insert into dbo.LENHKHOP(NGAYKHOP,SOLUONGKHOP,GIAKHOP,IDLENHDAT) values (@Ngay,@soluonggoc-@soluongMB,@giadatMB,@IDLENHDAT)
		END
	END
    CLOSE @CrsrVar
    DEALLOCATE @CrsrVar
   
GO
/****** Object:  StoredProcedure [dbo].[TAO_BANG_GIA]    Script Date: 25/05/2021 09:09:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TAO_BANG_GIA]
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DELETE FROM dbo.BANGGIATRUCTUYEN;
			INSERT INTO dbo.BANGGIATRUCTUYEN
			SELECT MACP,GIAMUA3,KLM3,GIAMUA2,KLM2,GIAMUA1,KLM1,GIAKHOP,KLKHOP,GIABAN1,KLB1,GIABAN2,KLB2,GIABAN3,KLB3 FROM 
			(
				SELECT LD.NAMECOL,LD.MACP AS MACP,LD.VALUE AS [VALUE] FROM
				(
				
					--LAY 3 GIADAT LON NHAT THEO TUNG MACP VOI LOAI M
					SELECT  NAMECOL = 'GIAMUA'+ CAST(MACP_rank AS nvarchar),MACP,GIADAT AS [VALUE] FROM 
					(
						SELECT MACP,GIADAT,LOAIGD,
							ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT DESC) AS MACP_RANK 
						FROM 
							(SELECT MACP,GIADAT,LOAIGD 
								FROM LENHDAT WHERE (TRANGTHAILENH = N'Chờ Khớp' OR TRANGTHAILENH = N'Khớp lệnh 1 phần')
									AND LOAIGD = 'M' 
									AND DAY(NGAYDAT)=DAY(GETDATE()) AND MONTH(NGAYDAT) = MONTH(GETDATE()) AND YEAR(NGAYDAT)=YEAR(GETDATE())
									GROUP BY MACP,GIADAT,LOAIGD) LENHDAT
					) LDM
					WHERE MACP_rank <= 3
					--	

					UNION
					--LAY 3 KLM LON NHAT THEO TUNG MACP VOI LOAI M
					SELECT  NAMECOL = 'KLM'+ CAST(MACP_rank AS nvarchar), MACP,SOLUONG AS [VALUE] FROM 
					(
						SELECT MACP,LOAIGD,SOLUONG,
							ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT DESC) AS MACP_RANK 
						FROM 
							(SELECT MACP,GIADAT,SUM(SOLUONG) AS SOLUONG,LOAIGD 
								FROM LENHDAT WHERE (TRANGTHAILENH = N'Chờ Khớp' OR TRANGTHAILENH = N'Khớp lệnh 1 phần')
									AND LOAIGD = 'M' 
									AND DAY(NGAYDAT)=DAY(GETDATE()) AND MONTH(NGAYDAT) = MONTH(GETDATE()) AND YEAR(NGAYDAT)=YEAR(GETDATE())
									GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					) LDM
					WHERE MACP_rank <= 3
					--

					UNION
					--LAY 3 GIABAN NHO NHAT THEO TUNG MACP VOI LOAI B 
					SELECT  NAMECOL = 'GIABAN'+ CAST(MACP_rank AS nvarchar),MACP,GIADAT AS [VALUE] FROM 
					(
						SELECT MACP,GIADAT,LOAIGD,
							ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT) AS MACP_RANK 
						FROM 
							(SELECT MACP,GIADAT,LOAIGD 
								FROM LENHDAT WHERE (TRANGTHAILENH = N'Chờ Khớp' OR TRANGTHAILENH = N'Khớp lệnh 1 phần')
									AND LOAIGD = 'B' 
									AND DAY(NGAYDAT)=DAY(GETDATE()) AND MONTH(NGAYDAT) = MONTH(GETDATE()) AND YEAR(NGAYDAT)=YEAR(GETDATE())
									GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					) LDM
					WHERE MACP_rank <= 3
					--

					UNION
					--LAY 3 KLB NHO NHAT THEO TUNG MACP VOI LOAI B
					SELECT  NAMECOL = 'KLB'+ CAST(MACP_rank AS nvarchar), MACP,SOLUONG AS [VALUE] FROM 
					(
						SELECT MACP,LOAIGD,SOLUONG,
							ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT) AS MACP_RANK 
						FROM 
							(SELECT MACP,GIADAT,SUM(SOLUONG) AS SOLUONG,LOAIGD 
								FROM LENHDAT WHERE (TRANGTHAILENH = N'Chờ Khớp' OR TRANGTHAILENH = N'Khớp lệnh 1 phần')
									AND LOAIGD = 'B' 
									AND DAY(NGAYDAT)=DAY(GETDATE()) AND MONTH(NGAYDAT) = MONTH(GETDATE()) AND YEAR(NGAYDAT)=YEAR(GETDATE())
									GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					) LDM
					WHERE MACP_rank <= 3
					--

					UNION
					--LAY GIA KHOP THEO TUNG MACP
						SELECT NAMECOL = 'GIAKHOP',TABLE1.MACP,GIAKHOP AS [VALUE] FROM TABLE1
						JOIN 
						(
							SELECT MACP,MAX(NGAYKHOP) AS NGAYKHOP FROM TABLE1 GROUP BY MACP
						) LK
						ON TABLE1.NGAYKHOP = LK.NGAYKHOP
					--

					UNION
					--LAY KL KHOP THEO TUNG MACP
					SELECT NAMECOL = 'KLKHOP',TABLE1.MACP,SOLUONG AS [VALUE] FROM TABLE1
						JOIN 
						(
							SELECT MACP,MAX(NGAYKHOP) AS NGAYKHOP FROM TABLE1 GROUP BY MACP
						) LK
						ON TABLE1.NGAYKHOP = LK.NGAYKHOP
					--
				) AS LD
			) X
			PIVOT 
			(
				MAX(VALUE)
				FOR NAMECOL IN (GIAMUA1,KLM1,GIAMUA2,KLM2,GIAMUA3,KLM3,GIABAN1,KLB1,GIAKHOP,KLKHOP,GIABAN2,KLB2,GIABAN3,KLB3)
			) P
		SELECT @@ROWCOUNT
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		DECLARE @ErrorMessage VARCHAR(2000);
		SELECT @ErrorMessage=ERROR_MESSAGE();
		RAISERROR(@ErrorMessage,16,1);
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_BANG_GIA]    Script Date: 25/05/2021 09:09:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UPDATE_BANG_GIA]
@MACP nchar(7)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF NOT EXISTS (SELECT * FROM BANGGIATRUCTUYEN WHERE MACP = @MACP)
			BEGIN
				INSERT INTO [dbo].[BANGGIATRUCTUYEN] (MACP) VALUES (@MACP)
			END
			UPDATE dbo.BANGGIATRUCTUYEN
			SET GIAMUA3=P.GIAMUA3,KLM3=P.KLM3,GIAMUA2=P.GIAMUA2,KLM2=P.KLM2,GIAMUA1=P.GIAMUA1,KLM1=P.KLM1,
				GIAKHOP=P.GIAKHOP,KLKHOP=P.KLKHOP,
				GIABAN1=P.GIABAN1,KLB1=P.KLB1,GIABAN2=P.GIABAN2,KLB2=P.KLB2,GIABAN3=P.GIABAN3,KLB3=P.KLB3
			FROM 
			(
				SELECT LD.NAMECOL,LD.MACP AS MACP,LD.VALUE AS [VALUE] FROM(
				
				--LAY 3 GIADAT LON NHAT THEO TUNG MACP VOI LOAI M
				SELECT  NAMECOL = 'GIAMUA'+ CAST(MACP_rank AS nvarchar),MACP,GIADAT AS [VALUE] 
				FROM (
					SELECT MACP,GIADAT,LOAIGD,
						ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT DESC) AS MACP_RANK 
					FROM 
						(SELECT MACP,GIADAT,LOAIGD 
								FROM LENHDAT WHERE (TRANGTHAILENH = N'Chờ Khớp' OR TRANGTHAILENH = N'Khớp lệnh 1 phần')
									AND LOAIGD = 'M' 
									AND DAY(NGAYDAT)=DAY(GETDATE()) AND MONTH(NGAYDAT) = MONTH(GETDATE()) AND YEAR(NGAYDAT)=YEAR(GETDATE())
									GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					WHERE MACP=@MACP
				) LDM
				WHERE MACP_rank <= 3
				--	

				UNION
				--LAY 3 KLM LON NHAT THEO TUNG MACP VOI LOAI M
				SELECT  NAMECOL = 'KLM'+ CAST(MACP_rank AS nvarchar), MACP,SOLUONG AS [VALUE] 
				FROM (
					SELECT MACP,LOAIGD,SOLUONG,
						ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT DESC) AS MACP_RANK 
					FROM 
						(SELECT MACP,GIADAT,SUM(SOLUONG) AS SOLUONG,LOAIGD 
								FROM LENHDAT WHERE (TRANGTHAILENH = N'Chờ Khớp' OR TRANGTHAILENH = N'Khớp lệnh 1 phần')
									AND LOAIGD = 'M' 
									AND DAY(NGAYDAT)=DAY(GETDATE()) AND MONTH(NGAYDAT) = MONTH(GETDATE()) AND YEAR(NGAYDAT)=YEAR(GETDATE())
									GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					WHERE MACP=@MACP
				) LDM
				WHERE MACP_rank <= 3
				--

				UNION
				--LAY 3 GIABAN NHO NHAT THEO TUNG MACP VOI LOAI B
				SELECT  NAMECOL = 'GIABAN'+ CAST(MACP_rank AS nvarchar),MACP,GIADAT AS [VALUE] 
				FROM (
					SELECT MACP,GIADAT,LOAIGD,
						ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT) AS MACP_RANK 
					FROM 
						(SELECT MACP,GIADAT,LOAIGD 
								FROM LENHDAT WHERE (TRANGTHAILENH = N'Chờ Khớp' OR TRANGTHAILENH = N'Khớp lệnh 1 phần')
									AND LOAIGD = 'B' 
									AND DAY(NGAYDAT)=DAY(GETDATE()) AND MONTH(NGAYDAT) = MONTH(GETDATE()) AND YEAR(NGAYDAT)=YEAR(GETDATE())
									GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					WHERE MACP=@MACP
				) LDM
				WHERE MACP_rank <= 3
				--

				UNION
				--LAY 3 KLB NHO NHAT THEO TUNG MACP VOI LOAI B
				SELECT  NAMECOL = 'KLB'+ CAST(MACP_rank AS nvarchar), MACP,SOLUONG AS [VALUE] 
				FROM (
					SELECT MACP,LOAIGD,SOLUONG,
						ROW_NUMBER() OVER (PARTITION BY MACP ORDER BY GIADAT) AS MACP_RANK 
					FROM 
						(SELECT MACP,GIADAT,SUM(SOLUONG) AS SOLUONG,LOAIGD 
								FROM LENHDAT WHERE (TRANGTHAILENH = N'Chờ Khớp' OR TRANGTHAILENH = N'Khớp lệnh 1 phần')
									AND LOAIGD = 'B' 
									AND DAY(NGAYDAT)=DAY(GETDATE()) AND MONTH(NGAYDAT) = MONTH(GETDATE()) AND YEAR(NGAYDAT)=YEAR(GETDATE())
									GROUP BY MACP,GIADAT,LOAIGD ) LENHDAT
					WHERE MACP=@MACP
				) LDM
				WHERE MACP_rank <= 3
				--

				UNION
				--LAY GIA KHOP THEO TUNG MACP
				SELECT NAMECOL = 'GIAKHOP',TABLE1.MACP,GIAKHOP AS [VALUE] FROM TABLE1
					JOIN 
						(
							SELECT MACP,MAX(NGAYKHOP) AS NGAYKHOP FROM TABLE1 WHERE MACP=@MACP GROUP BY MACP
						) LK
					ON TABLE1.NGAYKHOP = LK.NGAYKHOP
				--

				UNION
				--LAY KL KHOP THEO TUNG MACP
				SELECT NAMECOL = 'KLKHOP',TABLE1.MACP,SOLUONG AS [VALUE] FROM TABLE1
					JOIN 
						(
							SELECT MACP,MAX(NGAYKHOP) AS NGAYKHOP FROM TABLE1 WHERE MACP=@MACP GROUP BY MACP
						) LK
					ON TABLE1.NGAYKHOP = LK.NGAYKHOP
				--	

			) AS LD
		) X
		PIVOT 
		(
			MAX(VALUE)
			FOR NAMECOL IN (GIAMUA1,KLM1,GIAMUA2,KLM2,GIAMUA3,KLM3,GIABAN1,KLB1,GIAKHOP,KLKHOP,GIABAN2,KLB2,GIABAN3,KLB3)
		) P
		WHERE BANGGIATRUCTUYEN.MACP=@MACP
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		DECLARE @ErrorMessage VARCHAR(2000);
		SELECT @ErrorMessage=ERROR_MESSAGE();
		RAISERROR(@ErrorMessage,16,1);
	END CATCH
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[16] 2[46] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TABLE1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TABLE1'
GO
