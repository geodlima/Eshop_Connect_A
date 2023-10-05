-- Criação do banco de dados
CREATE DATABASE Eshop_connect_a;

-- Ativar o uso do Banco de Dados
USE Eshop_connect_a;

-- Tabela users
CREATE TABLE Users(
    pk_UserId        INT NOT NULL,
    name            VARCHAR(50) NOT NULL,
    phoneNumber        CHAR(12) NOT NULL,
    
    PRIMARY KEY (pk_UserId    )
);

 

-- Tabela Buyer 
CREATE TABLE Buyer(
    pk_UserId        INT NOT NULL,
    
    PRIMARY KEY (pk_UserId),
    FOREIGN KEY (pk_UserId) REFERENCES Users(pk_UserId)
);

 

-- Tabela Seller
CREATE TABLE Seller(
    pk_UserId        INT NOT NULL,
    
    PRIMARY KEY (pk_UserId),
    FOREIGN KEY (pk_UserId) REFERENCES Users(pk_UserId)
);

 

-- Tabela Bank Card
CREATE TABLE BankCard(
    pk_CardNumber VARCHAR(25) NOT NULL,
    ExpiryDate DATE,
    Bank VARCHAR(20),
    
    PRIMARY KEY(pk_CardNumber)
);

 

-- Tabela Credit Card
CREATE TABLE CreditCard(
    pk_CardNumber        VARCHAR(25) NOT NULL,
    fk_UserId            INT NOT NULL,
    organization        VARCHAR(20) NOT NULL,
    
    PRIMARY KEY (pk_CardNumber),
    FOREIGN KEY(pk_CardNumber) REFERENCES BankCard(pk_CardNumber),
    FOREIGN KEY (fk_UserId) REFERENCES Users(pk_UserId)
);

 

-- Tabela Debit Card
CREATE TABLE DebitCard(
    pk_CardNumber        VARCHAR(25) NOT NULL,
    fk_UserId            INT NOT NULL,
    organization        VARCHAR(20) NOT NULL,
    
    PRIMARY KEY (pk_CardNumber),
    FOREIGN KEY(pk_CardNumber) REFERENCES BankCard(pk_CardNumber),
    FOREIGN KEY (fk_UserId) REFERENCES users(pk_UserId)
);

 

-- Tabela Store
CREATE TABLE Store(
    pk_Sid             INT NOT NULL,
    name             VARCHAR(20),
    Province         VARCHAR(20),
    City             VARCHAR(20),
    StreetAddr         VARCHAR(20),
    CustomerGrade     INT,
    StartDate         DATE,

 

    PRIMARY KEY(pk_sid)
);
-- Tabela Brand
CREATE TABLE Brand(
    pk_BrandName VARCHAR(20) NOT NULL,
    
    PRIMARY KEY (pk_BrandName)
);

 

-- Tabela Product
CREATE TABLE Product(
    pk_Pid                 INT NOT NULL,
    fk_Sid                 INT NOT NULL,
    fk_Brand             VARCHAR(50) NOT NULL,
    name                 VARCHAR(100),
    Type                 VARCHAR(50),
    ModelNumber         VARCHAR(50),
    Color                 VARCHAR(50),
    Amount                 INT,
    Price                 INT,
    PRIMARY KEY(pk_Pid),
    FOREIGN KEY(fk_Sid) REFERENCES Store(pk_Sid),
    FOREIGN KEY(fk_Brand) REFERENCES Brand(pk_BrandName)
);

 

CREATE TABLE OrderItem(
    pk_ItemId         INT NOT NULL,
    fk_Pid             INT NOT NULL,
    Price             DECIMAL(10,2),
    CreationTime     DATE,
    PRIMARY KEY(pk_ItemId),
    FOREIGN KEY(fk_Pid) REFERENCES Product(pk_Pid)
);

 

CREATE TABLE Orders(
    pk_OrderNumber         INT NOT NULL,
    PaymentState         VARCHAR(12),
    CreationTime         DATE,
    TotalAmount         DECIMAL(10,2),
    PRIMARY KEY (pk_OrderNumber)
);

 

CREATE TABLE Comments(
    CreationTime             TIME NOT NULL,
    fk_UserId                 INT NOT NULL,
    fk_Pid                     INT NOT NULL,
    Grade                     FLOAT,
    Content                 VARCHAR(100),
    PRIMARY KEY(CreationTime,fk_UserId,fk_Pid), -- Chave composta
    FOREIGN KEY(fk_UserId) REFERENCES Users(pk_UserId),
    FOREIGN KEY(fk_Pid) REFERENCES Product(pk_Pid)
);

 

CREATE TABLE ServicePoint(
    pk_Spid         INT NOT NULL,
    StreetAddr         VARCHAR(40),
    City             VARCHAR(30),
    Province         VARCHAR(20),
    StartTime         TIME,
    EndTime         TIME,
    PRIMARY KEY(pk_Spid)
);

 

-- Tabela Save_to_ShoppingCart
CREATE TABLE Save_to_Shopping_Cart(
    pk_UserId             INT NOT NULL,
    pk_Pid                 INT NOT NULL,
    AddTime             TIME,
    Quantity             INT,
    PRIMARY KEY (pk_UserId,pk_Pid),
    FOREIGN KEY(pk_UserId) REFERENCES Buyer(pk_UserId),
    FOREIGN KEY(pk_Pid) REFERENCES Product(pk_Pid)
);

 

-- Tabela Contain
CREATE TABLE Contain(
    pk_OrderNumber             INT NOT NULL,
    fk_ItemId                 INT NOT NULL,
    Quantity                 INT,
    PRIMARY KEY (pk_OrderNumber,fk_ItemId),
    FOREIGN KEY(pk_OrderNumber) REFERENCES Orders(pk_OrderNumber),
    FOREIGN KEY(fk_ItemId) REFERENCES OrderItem(pk_ItemId)
);

 

-- Tabela Payment
CREATE TABLE Payment(
    fk_OrderNumber             INT NOT NULL,
    fk_CardNumber             VARCHAR(25) NOT NULL,
    PayTime                 DATETIME,
    PRIMARY KEY(fk_OrderNumber,fk_CardNumber),
    FOREIGN KEY(fk_OrderNumber) REFERENCES Orders(pk_OrderNumber),
    FOREIGN KEY(fk_CardNumber) REFERENCES BankCard(pk_CardNumber)
);

 

-- Tabela Address
CREATE TABLE Address(
    pk_AddrId                 INT NOT NULL,
    fk_UserId                 INT NOT NULL,
    name                     VARCHAR(50),
    ContactPhoneNumber         VARCHAR(20),
    Province                 VARCHAR(100),
    City                     VARCHAR(100),
    StreetAddr                 VARCHAR(100),
    PostCode                 VARCHAR(12),
    PRIMARY KEY(pk_AddrId),
    FOREIGN KEY(fk_UserId) REFERENCES Users(pk_UserId)
);

 

-- Tabela Deliver To
CREATE TABLE Deliver_To(
    fk_AddrId                 INT NOT NULL,
    fk_OrderNumber             INT NOT NULL,
    TimeDelivered             DATE,
    PRIMARY KEY(fk_AddrId,fk_OrderNumber),
    FOREIGN KEY(fk_AddrId) REFERENCES Address(pk_AddrId),
    FOREIGN KEY(fk_OrderNumber) REFERENCES Orders(pk_OrderNumber)
);

 

-- Tabela Manage
CREATE TABLE Manage(
    fk_UserId                 INT NOT NULL,
    fk_Sid                     INT NOT NULL,
    SetUpTime                 DATE,
    PRIMARY KEY(fk_UserId,fk_Sid),
    FOREIGN KEY(fk_UserId) REFERENCES Seller(pk_UserId),
    FOREIGN KEY(fk_Sid) REFERENCES Store (pk_Sid)
);

 

-- Tabela After Sales Service At
CREATE TABLE After_Sales_Service_At(
    fk_BrandName             VARCHAR(20) NOT NULL,
    fk_Spid                 INT NOT NULL,
    PRIMARY KEY(fk_BrandName, fk_Spid),
    FOREIGN KEY(fk_BrandName) REFERENCES Brand (pk_BrandName),
    FOREIGN KEY(fk_Spid) REFERENCES ServicePoint(pk_Spid)
);