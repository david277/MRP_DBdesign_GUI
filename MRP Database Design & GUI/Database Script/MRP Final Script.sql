-- DAVID, ALEX, JOSH
-- Script tath implements the database Design

CREATE DATABASE manufacturer
GO

USE manufacturer
GO

CREATE SCHEMA mrp
GO

CREATE TABLE [mrp].[inventory] (
    inventoryID int NOT NULL PRIMARY KEY,
    vendorID int,
    itemName varChar(30),
    itemDesc varChar(200),
    itemUnit varChar(20),
    itemType varChar(2),
    itemFCost varChar(20),
    itemVCost varChar(20),
    bestPrice varChar(20),
    manufacturer varChar(30),
    --Check imagefile later
    imageFile varChar(100)
    );
GO

CREATE TABLE [mrp].[safetyStock] (
    safetyStockID int NOT NULL PRIMARY KEY IDENTITY,
    inventoryID int,
    safetyStock varChar(20),
    maxLevel int,
    orderLeadTime varChar(20)
    );
GO

CREATE TABLE [mrp].[quantityStatus] (
    statusID int NOT NULL PRIMARY KEY IDENTITY,
    inventoryID int,
    --onHand, onOrder, inTransit are all binary. 1/0 Y/N
    onHand int,
    onOrder int,
    inTransit int,
    );
GO

CREATE TABLE [mrp].[Vendor] (
    vendorID int NOT NULL PRIMARY KEY IDENTITY,
    vendorName varChar(40),
    contact varChar(40),
    contactNumber varChar(15),
    addressStreet varChar(40),
    addressCity varChar(40),
    addressState varChar(40),
    letterRating varChar(5),
);
GO

CREATE TABLE [mrp].[vendorProduct] (
    vendorID int,
    inventoryID int,
    productName varChar(30),
    primary key (vendorID, inventoryID)
);
GO

CREATE TABLE [mrp].[customer] (
    customerID int NOT NULL PRIMARY KEY IDENTITY,
    customerName varChar(30),
    addressBilling varChar(30),
    shippingStreet varChar(30),
    shippingCity varChar(30),
    shippingState varChar(30),
    creditCard varChar(16),
    creditRefID varChar(30)
);

CREATE TABLE [mrp].[BoM] (
    BillOfMaterialID int NOT NULL PRIMARY KEY IDENTITY,
    ProductAssemblyID int,
    ComponentID int,
    UnitMeasureCode int,
    BoMLevel int,
    PerAssemblyQuantity int
    );

create table [mrp].[HILODriver](
    DriverID int,
    DriverName char(30) NOT NULL
);

create table [mrp].[JobOrder] (
    JobOrderID int,
    inventoryID int
);


create table [mrp].[PurchaseOrder] (
    POid int PRIMARY KEY,
    VendorID int,
    Quantiy int,
    Unit char(15),
    CostPerUnit money,
    FulfilledDate DATE,
    BilltoAddress char(50)
);


create table [mrp].[PurchaseOrderLine] (
    POid int,
    PurchaseOrderLineID int,
    PurchaseOrderLineItemPrice money,
	PRIMARY KEY (POid, PurchaseOrderLineID)
);


create table [mrp].[Resources](
    ResourceID int PRIMARY KEY,
    ResourceName char (50)
);

create table [mrp].[CreditReference] (
    CreditReferenceID int PRIMARY KEY,
    CustomerID int,
    AccountNumber int,
    CurrentBalance money,
    CreditLimit money
);

CREATE TABLE [mrp].[SalesTax](
    StateCode varChar(2),
    SalesTax int
);

CREATE TABLE [mrp].[invoiceLineItems](
    invoiceID int NOT NULL,
    invoiceSequence int,
    invoiceLineItemPrice money,
	inventoryID int,
	quantityOfItem int,
    orderStatus varChar(20),
	CONSTRAINT [PK_invoiceLineItems] PRIMARY KEY CLUSTERED (
	invoiceID ASC,
	invoiceSequence ASC)
);

CREATE TABLE [mrp].[invoice](
    invoiceID int NOT NULL PRIMARY KEY,
    customerID int,
    shipmentType int,
    orderTotalPrice money,
    estimatedShippingDate DATE,
    invoiceDateTime datetime,

);

GO

--CONSTRAINTS

--Add inventoryID as a foreign key in vendor table
ALTER TABLE [mrp].[inventory]
ADD CONSTRAINT [FK_inventoryIDVID] FOREIGN KEY (vendorID)
    REFERENCES [mrp].[Vendor] (vendorID)

--Add inventoryID as a foreign key in safetyStock table
ALTER TABLE [mrp].[safetyStock]
ADD CONSTRAINT [FK_inventoryIDSS] FOREIGN KEY (inventoryID)
    REFERENCES [mrp].[inventory] (inventoryID)

--Add inventoryID as a foreign key in quantityStatus table
ALTER TABLE [mrp].[quantityStatus]
ADD CONSTRAINT [FK_inventoryIDQS] FOREIGN KEY (inventoryID)
    REFERENCES [mrp].[inventory] (inventoryID)

--Add inventoryID as a foreign key in vendorProduct table
ALTER TABLE [mrp].[vendorProduct]
ADD CONSTRAINT [FK_inventoryIDVS] FOREIGN KEY (inventoryID)
    REFERENCES [mrp].[inventory] (inventoryID)

--Add invoiceID as a foreign key in vendorProduct table
ALTER TABLE [mrp].[invoiceLineItems]
WITH NOCHECK ADD CONSTRAINT [FK_invoiceID] FOREIGN KEY(invoiceID)
   REFERENCES [mrp].[invoice] (invoiceID)

--Add customerID as a foreign key in invoice table
ALTER TABLE [mrp].[invoice]
ADD CONSTRAINT [FK_customerIDI] FOREIGN KEY (customerID)
    REFERENCES [mrp].[customer] (customerID)

--Add inventoryID as a foreign key in invoiceLineItems table
ALTER TABLE [mrp].[invoiceLineItems]
ADD CONSTRAINT [FK_inventoryIDILI] FOREIGN KEY (inventoryID)
    REFERENCES [mrp].[inventory] (inventoryID)

--Add customerID as a foreign key in CreditReference table
ALTER TABLE [mrp].[CreditReference]
ADD CONSTRAINT [FK_customerIDCR] FOREIGN KEY (customerID)
    REFERENCES [mrp].[customer] (customerID)

--Add vendorID as a foreign key in PurchaseOrder table
ALTER TABLE [mrp].[PurchaseOrder]
ADD CONSTRAINT [FK_vendorID] FOREIGN KEY (vendorID)
    REFERENCES [mrp].[vendor] (vendorID)

--Add POid as a foreign key in PurchaseOrderLine table
ALTER TABLE [mrp].[PurchaseOrderLine]
ADD CONSTRAINT [FK_POid] FOREIGN KEY (POid)
    REFERENCES [mrp].[PurchaseOrder] (POid)

--Add inventoryID as a foreign key in JobOrder table
ALTER TABLE [mrp].[JobOrder]
ADD CONSTRAINT [FK_inventoryIDJO] FOREIGN KEY (inventoryID)
    REFERENCES [mrp].[inventory] (inventoryID)
GO



--Script That Provides Test Data

INSERT INTO [mrp].[customer] (
    customerName,
    addressBilling,
    shippingStreet,
    shippingCity,
    shippingState,
    creditCard,
    creditRefID)
    VALUES ('Jimbo', 'Burton', 'Burton', 'Grand Rapids', 'MI', '1234123412341234', '15'),
	('Grant', 'Beltline', 'Lake', 'Wyoming', 'MI', '1234567890123456', '15'),
	('Jerry', 'Clifford', 'Clifford', 'Irvine', 'CA', '0987654321098765', '12'),
	('Gary', 'Freedom', 'Freedom', 'Gary', 'Indiana', '123423458756523', '23'),
	('Larry', 'Smith', 'Smith', 'Pawnee', 'Indiana', '21234234234234', '1')

SET IDENTITY_INSERT [mrp].[Vendor] ON
INSERT INTO [mrp].[Vendor] ( vendorID, 
vendorName, 
contact, 
contactNumber, 
addressStreet, 
addressCity, 
addressState, 
letterRating)
VALUES (1,'US Postal Service','Alberto Francesco', '(800) 555-1205', '3201 Burton SE','Madison', 'WI', 'AA'), 
(2,'National Information Data Ctr','Irvin Ania', '(301) 555-8950', '96621 Sentia SE', 'Washington', 'DC', 'A'),
(3, 'Register of Copyrights','Liana Lukas', NULL, 'Library of Congress', 'Washington', 'DC', 'C'),
(4, 'Jobtrak','Quinn Kenzie','(800) 555-8725' ,'1990 Westwood Blvd Ste 260', 'Los Angeles', 'CA','B')
SET IDENTITY_INSERT [mrp].[Vendor] OFF

INSERT INTO [mrp].[inventory] (
    inventoryID,
	vendorID,
	itemName,
	itemDesc,
	itemUnit,
	itemType,
	itemFCost,
	itemVCost,
	bestPrice,
	manufacturer,
	imageFile)
    VALUES (1, 1, 'Murach', 'Teaches c# in a confusing way', '2lb', 'FP', '10', '8', '12', 'Jimmy Johns', 'xjf45ads'),
	(2, 2, 'Hat', 'Warm and cozy', '1lb', 'FP', '12', '10', '10', 'Subway', 'asdfaqwer'),
	(3, 3, 'Gears', 'Used in bikes', '3oz', 'RP', '5', '25', '15', 'McDonalds', '57sgdfuy7'),
	(4, 4, 'Cable', 'Wires for AC adapter', '3 feet', 'RP', '35', '17', '25', 'Burger King', 'sdfgs89mj'),
	(5, 1, 'Glass', 'Screen for monitor', '1lb', 'RP', '25', '46', '13', 'Wendys', 'asdfz90x'),
	(6, 2, 'Keyboard', 'Mechanical, very loud', '1.4lb','FP', '60', '70', '15', 'Arbys', NULL),
	(7, 3, 'Cushion', 'Very comfortable', '1.8 feet', 'RP', '40', '35', '37', 'JackInTheBox', '78694023'),
	(8, 4, 'Keys', 'For a mechanical keyboard', '1/4 inch', 'RP', '10', '15', '13', 'Pizza Hut', '675849asdf')

INSERT INTO [mrp].[invoice] (
	invoiceID,
    customerID,
    shipmentType, -- boolean. 1 for one shipment, 0 for split shipment
    orderTotalPrice,
    estimatedShippingDate,
    invoiceDateTime)
	VALUES (1, 1, 1, 625, '1999-04-27', '1999-04-20 00:00:01'),
	(2, 2, 0, 850, '1999-02-23', '1999-02-20 00:01:21'),
	(3, 3, 1, 400, '1999-03-15', '1999-03-01 23:04:01'),
	(4, 4, 1, 725, '1999-04-15', '1999-04-01 12:02:01'),
	(5, 5, 0, 875, '1999-01-12', '1999-01-09 06:52:01')

-- david start: insert customers with multiple orders
INSERT INTO [mrp].[invoice] (
	invoiceID,
    customerID,
    shipmentType, -- boolean. 1 for one shipment, 0 for split shipment
    orderTotalPrice,
    estimatedShippingDate,
    invoiceDateTime)
	VALUES(6, 3, 1, 90, '1999-03-15', '1999-03-01 23:04:01'),
	(7, 4, 1, 85, '1999-04-15', '1999-04-01 12:02:01'),
	(8, 5, 0, 30, '1999-01-12', '1999-01-09 06:52:01')
	
INSERT INTO [mrp].[invoiceLineItems] (
    invoiceID,
	invoiceSequence,
    invoiceLineItemPrice,
	inventoryID, 
	quantityOfItem,
    orderStatus)
    VALUES 
	--Invoice 6 Line Items
	(6, 1, 10, 1, 3, 'Delivered'),
	(6, 2, 10, 2, 2, 'Processing'),
	(6, 3, 10, 3, 1, 'Delivered'),
	(6, 4, 10, 4, 1, 'Delivered'),
	(6, 5, 10, 5, 1, 'Delivered'),
	(6, 6, 10, 6, 1, 'Processing'),

		--Invoice 7 Line Items
	(7, 1, 25, 1, 3, 'Delivered'),
	(7, 2, 5, 2, 2, 'Processing'),


		--Invoice 8 Line Items
	(8, 1, 5, 1, 3, 'Delivered'),
	(8, 2, 5, 2, 2, 'Processing'),
	(8, 3, 5, 3, 1, 'Delivered')
-- david end


INSERT INTO [mrp].[invoiceLineItems] (
    invoiceID,
	invoiceSequence,
    invoiceLineItemPrice,
	inventoryID, 
	quantityOfItem,
    orderStatus)
    VALUES 
	--Invoice 1 Line Items
	(1, 1, 25, 1, 3, 'Delivered'),
	(1, 2, 50, 2, 2, 'Processing'),
	(1, 3, 75, 3, 1, 'Delivered'),
	(1, 4, 100, 4, 1, 'Delivered'),
	(1, 5, 125, 5, 1, 'Delivered'),
	(1, 6, 150, 6, 1, 'Processing'),

	--Invoice 2 Line Items
	(2, 2, 25, 1, 2, 'Waiting to ship'),
	(2, 1, 75, 3, 2, 'Delivered'),
	(2, 3, 150, 1, 4, 'Processing'),
	(2, 4, 50, 2, 1, 'Waiting to ship'),

	--Invoice 3 Line Items
	(3, 2, 100, 4, 1, 'Processing'),
	(3, 1, 200, 8, 1, 'Processing'),
	(3, 3, 25, 1, 4, 'Processing'),

	--Invoice 4 Line Items
	(4, 1, 25, 1, 5, 'Waiting to ship'),
	(4, 2, 150, 6, 1, 'Waiting to ship'),
	(4, 3, 75, 3, 2, 'Waiting to ship'),
	(4, 4, 100, 4, 2, 'Waiting to ship'),
	(4, 5, 50, 2, 2, 'Waiting to ship'),

	--Invoice 5 Line Items
	(5, 1, 50, 2, 4, 'Processing'),
	(5, 2, 25, 1, 8, 'Processing'),
	(5, 3, 200, 8, 1, 'Processing'),
	(5, 4, 75, 3, 2, 'Processing'),
	(5, 5, 125, 5, 1, 'Processing')

	

INSERT INTO [mrp].[vendorProduct] (vendorID,inventoryID,productName)
VALUES (1, 1, 'Stamps'), 
        (2, 2, 'Board Cards'),
        (3, 3, 'Paper'),
        (4,4, 'Nails')

SET IDENTITY_INSERT [mrp].[BoM] ON
INSERT INTO [mrp].[BoM] (BillOfMaterialID,
 ProductAssemblyID, 
ComponentID, 
UnitMeasureCode, 
BoMLevel, 
PerAssemblyQuantity)
VALUES (1,1,1,1,1,1), 
(2,2,2,2,2,2), 
(3,3,3,3,3,3),
(4,4,4,4,4,4)
SET IDENTITY_INSERT [mrp].[BoM] OFF

INSERT INTO [mrp].[HILODriver] (DriverID, DriverName)
VALUES (1, 'John Cena'), 
(2, 'Barack Ohana'), 
(3, 'Lonald Prump'), 
(4, 'Tillary Linton')

INSERT INTO [mrp].[JobOrder](JobOrderID, InventoryID)
VALUES (1,1),
(2,2),
(3,3),
(4,4)

INSERT INTO  [mrp].[PurchaseOrder] 
(POid,
VendorID,
Quantiy,
Unit,
CostPerUnit,
FulfilledDate,
BilltoAddress)
VALUES(1, 1,23, 'cases', 25,'2018-01-11', '9753 Highland Street Bristol, DC 06010'),
(2, 2, 14, 'cases', 10, '2018-01-25', '24 Cambridge Ave. Buford, CA 30518'),
(3, 3, 30, 'cases', 5, '2018-02-12', '962 Henry Ave. Hialeah, FL 33010'),
(4, 4, 120, 'kg', 37, '2018-02-22', '9 N. Tanglewood St. Shakopee, WI 55379')


INSERT INTO  [mrp].[PurchaseOrderLine]
(POid,
PurchaseOrderLineID,
PurchaseOrderLineItemPrice
)
VALUES (1, 1, 20),
(2, 2, 12),
(3, 3, 26),
(4, 4, 54)

INSERT INTO  [mrp].[Resources]
(ResourceID,
ResourceName
)
VALUES (1, 'Oil'),
(2, 'Water'),
(3, 'Coal'),
(4, 'Uranium')

INSERT INTO  [mrp].[CreditReference]
( CreditReferenceID,
CustomerID,
AccountNumber,
CurrentBalance,
CreditLimit
)
VALUES (1,1, 00000001, 230.83, 1000),
(2,1, 00000002, 130.11, 1000),
(3,1, 00000003, 430.83, 1000),
(4,2, 00000004, 720.14, 1000)

INSERT INTO  [mrp].[SalesTax]
(StateCode,
SalesTax
)
VALUES ('CA', 8.54),
('WI', 5.42),
('DC', 5.75),
('FL', 6.80)
GO

--Stored Procedure Script for updating the total cost of the order
CREATE PROCEDURE updtOrderTotal
	@invID INT 		  
AS
BEGIN
	DECLARE
	@out int;
		SELECT @out = SUM(invoiceLineItemPrice*quantityOfItem)
		FROM mrp.invoiceLineItems
		WHERE invoiceID = @invID;

		UPDATE mrp.invoice
		SET orderTotalPrice=@out
		WHERE invoiceID = @invID
END
GO


 --Stored Procedure Script for updating the quantity of items of the order
CREATE PROCEDURE updtQty
	@invID INT,
	@invSeq INT,
	@qty INT
AS
BEGIN
	UPDATE mrp.invoiceLineItems
    SET quantityOfItem=@qty
    WHERE invoiceID = @invID
	AND
	invoiceSequence = @invSeq

END
GO


CREATE VIEW vInvoiceLineItemsAndInventory AS
SELECT  
mrp.invoiceLineItems.invoiceID,
mrp.invoiceLineItems.invoiceSequence,
mrp.inventory.inventoryID,
mrp.inventory.itemName,
mrp.invoiceLineItems.quantityOfItem,
mrp.invoiceLineItems.invoiceLineItemPrice,
mrp.invoiceLineItems.orderStatus
FROM mrp.invoiceLineItems LEFT OUTER JOIN mrp.inventory
ON mrp.inventory.inventoryID = mrp.invoiceLineItems.inventoryID
GO

CREATE INDEX inventoryIndex
ON mrp.inventory (
inventoryID,
itemName,
VendorID);
GO

CREATE INDEX invoiceILIndex
ON mrp.invoiceLineItems (
invoiceID,
invoiceSequence,
inventoryID,
quantityOfItem,
invoiceLineItemPrice)

--SELECT * FROM mrp.invoice
--SELECT * FROM mrp.invoiceLineItems
--EXEC updtOrderTotal 1;

	--	SELECT SUM(invoiceLineItemPrice*quantityOfItem)
		--FROM mrp.invoiceLineItems
	--	WHERE invoiceID = 3;

--use master
--drop database manufacturer	