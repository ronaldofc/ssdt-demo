CREATE PROCEDURE [data].[Populate_Person_PhoneNumberType]
AS
BEGIN
/*
	Table's data:    [Person].[PhoneNumberType]
	Data Source:     [DEV19].[AdventureWorks2014]
	Created on:      18/10/2019 15:06:49
	Scripted by:     DEV19\Administrator
	Generated by     Data Script Writer - ver. 2.0.0.0
*/
PRINT 'Populating data into [Person].[PhoneNumberType]';

IF OBJECT_ID('tempdb.dbo.#Person_PhoneNumberType') IS NOT NULL DROP TABLE #Person_PhoneNumberType;
SELECT * INTO #Person_PhoneNumberType FROM [Person].[PhoneNumberType] WHERE 0=1;
SET IDENTITY_INSERT #Person_PhoneNumberType ON;

INSERT INTO #Person_PhoneNumberType 
 ([PhoneNumberTypeID], [Name], [ModifiedDate])
SELECT CAST([PhoneNumberTypeID] AS int) AS [PhoneNumberTypeID], [Name], [ModifiedDate] FROM 
(VALUES
	  (1,	'Cell',	'20171213 13:19:22.273')
	, (2,	'Home',	'20171213 13:19:22.273')
	, (3,	'Work',	'20171213 13:19:22.273')
) as v ([PhoneNumberTypeID], [Name], [ModifiedDate]);

SET IDENTITY_INSERT #Person_PhoneNumberType OFF;
SET IDENTITY_INSERT [Person].[PhoneNumberType] ON;

WITH cte_data as (SELECT CAST([PhoneNumberTypeID] AS int) AS [PhoneNumberTypeID], [Name], [ModifiedDate] FROM [#Person_PhoneNumberType])
MERGE [Person].[PhoneNumberType] as t
USING cte_data as s
	ON t.[PhoneNumberTypeID] = s.[PhoneNumberTypeID]
WHEN NOT MATCHED BY target THEN
	INSERT ([PhoneNumberTypeID], [Name], [ModifiedDate])
	VALUES (s.[PhoneNumberTypeID], s.[Name], s.[ModifiedDate])
WHEN MATCHED THEN 
	UPDATE SET 
	[Name] = s.[Name], [ModifiedDate] = s.[ModifiedDate]
WHEN NOT MATCHED BY source THEN
	DELETE
;

SET IDENTITY_INSERT [Person].[PhoneNumberType] OFF;

DROP TABLE #Person_PhoneNumberType;

-- End data of table: [Person].[PhoneNumberType] --
END
GO
