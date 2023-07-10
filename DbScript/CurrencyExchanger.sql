CREATE DataBase CurrencyExchanger_db
GO
--DROP DataBase CurrencyExchanger_db

USE CurrencyExchanger_db
GO

ALTER AUTHORIZATION ON DATABASE::CurrencyExchanger_db TO [Valera]
GO
---------------------------------------------------------------------------------


CREATE TABLE Operators (
	Operator_Id INT IDENTITY(1,1) PRIMARY KEY,
	Operator_Name NVARCHAR(16) NOT NULL,
	Operator_Password NVARCHAR(128) NOT NULL,
	Operator_Type NVARCHAR(1) NOT NULL,
	CONSTRAINT FK_Operator_Type FOREIGN KEY (Operator_Type) REFERENCES Operators_Type (Operator_Type)
);
GO
--DROP TABLE IF EXISTS Operators;


CREATE TABLE Operators_Type (
	Operator_Type NVARCHAR(1) NOT NULL PRIMARY KEY,
	Position NVARCHAR(64) NOT NULL
);
GO
--DROP TABLE IF EXISTS Operators_Type;


CREATE TABLE Operations (
	Operation_Id INT IDENTITY(1,1) PRIMARY KEY,
	Operator_Id INT NOT NULL,
	Digital_Currency_Code INT NOT NULL,
	Date_Of_Issue DATETIME,
	Transaction_Amount NVARCHAR(64) NOT NULL,
	Transaction_Delivery NVARCHAR(64) NOT NULL,
	Operation_Type NVARCHAR(1) NOT NULL,
	CONSTRAINT FK_Operator_Id3 FOREIGN KEY (Operator_Id) REFERENCES Operators (Operator_Id),
	CONSTRAINT FK_Operation_Type2 FOREIGN KEY (Operation_Type) REFERENCES Operations_Type (Operation_Type),
	CONSTRAINT FK_Digital_Currency_Code4 FOREIGN KEY (Digital_Currency_Code) REFERENCES Currencies (Digital_Currency_Code)
);
GO
--DROP TABLE IF EXISTS Operations;


CREATE TABLE Operations_Type (
	Operation_Type NVARCHAR(1) NOT NULL PRIMARY KEY,
	Operation_Name NVARCHAR(64) NOT NULL
);
GO
--DROP TABLE IF EXISTS Operations_Type;


CREATE TABLE Banking_Information (
	Bank_Amount NVARCHAR(16) NOT NULL PRIMARY KEY,
	Operation_Id INT NOT NULL,
	Digital_Currency_Code INT NOT NULL,
	Date_Of_Issue DATETIME,
	CONSTRAINT FK_Operation_Id FOREIGN KEY (Operation_Id) REFERENCES Operations (Operation_Id),
	CONSTRAINT FK_Digital_Currency_Code5 FOREIGN KEY (Digital_Currency_Code) REFERENCES Currencies (Digital_Currency_Code)
);
GO
--DROP TABLE IF EXISTS Banking_Information;


CREATE TABLE Currencies (
	Digital_Currency_Code INT NOT NULL PRIMARY KEY,
	Alphabetic_Currency_Code NVARCHAR(3) NOT NULL,
	Currency_Name NVARCHAR(64) NOT NULL,
	Number_Of_Currency_Units NVARCHAR(16) NOT NULL
);
GO
--DROP TABLE IF EXISTS Currencies;


CREATE TABLE Coefficients (
	Coefficient NVARCHAR(16) PRIMARY KEY,
	Digital_Currency_Code INT NOT NULL,
	Operation_Type NVARCHAR(1) NOT NULL,
	Date_Of_Issue DATETIME,
	Date_Of_The_Start_Action DATETIME,
	CONSTRAINT FK_Digital_Currency_Code FOREIGN KEY (Digital_Currency_Code) REFERENCES Currencies (Digital_Currency_Code),
	CONSTRAINT FK_Operation_Type FOREIGN KEY (Operation_Type) REFERENCES Operations_Type (Operation_Type)
);
GO
--DROP TABLE IF EXISTS Coefficients;


CREATE TABLE Rate_Purchase_Sale  (
	Operator_Id INT NOT NULL,
	Digital_Currency_Code INT NOT NULL,
	Rate_Purchase NVARCHAR(16) NOT NULL,
	Rate_Sale NVARCHAR(16) NOT NULL,
	Coefficient NVARCHAR(16),
	Date_Of_Issue DATETIME,
	Date_Of_The_Start_Action DATETIME,
	CONSTRAINT FK_Digital_Currency_Code2 FOREIGN KEY (Digital_Currency_Code) REFERENCES Currencies (Digital_Currency_Code),
	CONSTRAINT FK_Operator_Id FOREIGN KEY (Operator_Id) REFERENCES Operators (Operator_Id),
	CONSTRAINT FK_Coefficient FOREIGN KEY (Coefficient) REFERENCES Coefficients (Coefficient)
);
GO
--DROP TABLE IF EXISTS Rate_Purchase_Sale;


CREATE TABLE Rate_Of_Conversion (
	Operator_Id INT NOT NULL,
	Digital_Currency_Code INT NOT NULL,
	Rate_Conversion NVARCHAR(16) NOT NULL,
	Coefficient NVARCHAR(16),
	Date_Of_Issue DATETIME,
	Date_Of_The_Start_Action DATETIME,
	CONSTRAINT FK_Digital_Currency_Code3 FOREIGN KEY (Digital_Currency_Code) REFERENCES Currencies (Digital_Currency_Code),
	CONSTRAINT FK_Operator_Id2 FOREIGN KEY (Operator_Id) REFERENCES Operators (Operator_Id),
	CONSTRAINT FK_Coefficient2 FOREIGN KEY (Coefficient) REFERENCES Coefficients (Coefficient)
);
GO
--DROP TABLE IF EXISTS Rate_Of_Conversion;


ALTER AUTHORIZATION ON DATABASE::[Obmennik3_db] TO [Valera]
GO
---------------------------------------------------------------------------------

SELECT * FROM Operators;
SELECT * FROM Operators_Type;
SELECT * FROM Operations;
SELECT * FROM Operations_Type;
SELECT * FROM Banking_Information;
SELECT * FROM Currencies;
SELECT * FROM Coefficients;
SELECT * FROM Rate_Purchase_Sale;
SELECT * FROM Rate_Of_Conversion;