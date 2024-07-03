drop database if exists pharmacymanagementsystem;
create database pharmacymanagementsystem;

-- Create Supplier table
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY NOT NULL,
    CompanyName VARCHAR(100) NOT NULL,
    ContactPerson VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Address VARCHAR(200) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

-- Create Medication table
CREATE TABLE Medication (
    MedicationID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Form VARCHAR(50) NOT NULL,
    ReorderLevel INT NOT NULL CHECK (ReorderLevel >= 0),
    ExpirationDate DATE NOT NULL,
    SupplierID INT NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- Create Inventory table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY NOT NULL,
    MedicationID INT NOT NULL,
    QuantityInStock INT NOT NULL CHECK (QuantityInStock >= 0),
    LastUpdated DATE NOT NULL,
    Room VARCHAR(50) NOT NULL,
    Shelf_no INT NOT NULL CHECK (Shelf_no > 0),
    FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID)
);

-- Create PurchaseOrder table with auto-increment PurchaseOrderID 
CREATE TABLE PurchaseOrder ( 
PurchaseOrderID INT AUTO_INCREMENT PRIMARY KEY, 
OrderDate DATE NOT NULL, 
Status VARCHAR(50) NOT NULL CHECK (Status IN ('Pending', 'Completed', 'Cancelled')), 
ExpectedDeliveryDate DATE NOT NULL, 
SupplierID INT NOT NULL, 
Total_Amount DECIMAL(10, 2) DEFAULT 0, 
FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID) ); 
-- Create PurchaseOrderDetail table 
CREATE TABLE PurchaseOrderDetail ( 
PurchaseOrderID INT NOT NULL, 
MedicationID INT NOT NULL, 
QuantityOrdered INT NOT NULL CHECK (QuantityOrdered > 0), 
UnitPrice DECIMAL(10, 2) NOT NULL CHECK (UnitPrice >= 0), 
Total_Price DECIMAL(10, 2) GENERATED ALWAYS AS (QuantityOrdered * UnitPrice) STORED, 
PRIMARY KEY (PurchaseOrderID, MedicationID), 
FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrder(PurchaseOrderID), 
FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID) );

-- Create Alert table with auto-increment AlertID
CREATE TABLE Alert (
    AlertID INT AUTO_INCREMENT PRIMARY KEY,
    MedicationID INT NOT NULL,
    AlertType VARCHAR(50) NOT NULL,
    AlertDate DATE NOT NULL,
    Resolved BOOLEAN NOT NULL,
    FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID)
);

-- Create Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY NOT NULL,
    F_name VARCHAR(50) NOT NULL,
    L_name VARCHAR(50) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);








-- Populate Supplier table
INSERT INTO Supplier (SupplierID, CompanyName, ContactPerson, Phone, Email, Address, City, State, Country)
VALUES
(1, 'Pharma Supplier PLC', 'Abebe Bekele', '+251911234567', 'info@pharmasupplier.com', 'Bole Road', 'Addis Ababa', 'Addis Ababa', 'Ethiopia'),
(2, 'Health Products Inc.', 'Mulu Tadesse', '+251922345678', 'contact@healthproducts.com', 'Piassa', 'Gondar', 'Amhara', 'Ethiopia'),
(3, 'Med Supply Co.', 'Tigist Kebede', '+251933456789', 'sales@medsupply.com', 'Main Street', 'Hawassa', 'SNNPR', 'Ethiopia'),
(4, 'Dire Pharma Ltd.', 'Kassahun Mengistu', '+251944567890', 'support@direpharma.com', 'Haramaya Avenue', 'Dire Dawa', 'Dire Dawa', 'Ethiopia'),
(5, 'Alemu Pharmaceuticals', 'Sisay Alemu', '+251955678901', 'info@alemupharma.com', 'Jimma Road', 'Jimma', 'Oromia', 'Ethiopia');


-- Populate Medication table
INSERT INTO Medication (MedicationID, Name, Category, Form, ReorderLevel, ExpirationDate, SupplierID)
VALUES
(1, 'Paracetamol', 'Analgesic', 'Tablet', 20, '2024-06-30', 1),
(2, 'Ibuprofen', 'Anti-inflammatory', 'Tablet', 15, '2025-01-15', 2),
(3, 'Amoxicillin', 'Antibiotic', 'Capsule', 10, '2024-12-01', 3),
(4, 'Ciprofloxacin', 'Antibiotic', 'Tablet', 10, '2023-11-25', 4),
(5, 'Doxycycline', 'Antibiotic', 'Capsule', 5, '2025-02-20', 5),
(6, 'Metformin', 'Antidiabetic', 'Tablet', 15, '2024-10-10', 1),
(7, 'Aspirin', 'Analgesic', 'Tablet', 20, '2025-08-15', 2),
(8, 'Lisinopril', 'Antihypertensive', 'Tablet', 10, '2024-07-20', 3),
(9, 'Atorvastatin', 'Lipid-lowering', 'Tablet', 10, '2025-05-25', 4),
(10, 'Omeprazole', 'Antacid', 'Capsule', 5, '2024-09-30', 5);

-- Populate Inventory table
INSERT INTO Inventory (InventoryID, MedicationID, QuantityInStock, LastUpdated, Room, Shelf_no)
VALUES
(1, 1, 10, '2024-06-01', 'A1', 1),
(2, 2, 25, '2024-06-01', 'A2', 2),
(3, 3, 5, '2024-06-01', 'B1', 3),
(4, 4, 15, '2024-06-01', 'B2', 4),
(5, 5, 2, '2024-06-01', 'C1', 5),
(6, 6, 20, '2024-06-01', 'C2', 6),
(7, 7, 8, '2024-06-01', 'D1', 7),
(8, 8, 12, '2024-06-01', 'D2', 8),
(9, 9, 30, '2024-06-01', 'E1', 9),
(10, 10, 40, '2024-06-01', 'E2', 10);

-- Populate PurchaseOrder table
INSERT INTO PurchaseOrder (PurchaseOrderID, OrderDate, Status, ExpectedDeliveryDate, SupplierID)
VALUES
(1, '2024-06-01', 'Completed', '2024-06-08', 1),
(2, '2024-06-02', 'Completed', '2024-06-09', 2),
(3, '2024-06-03', 'Pending', '2024-06-10', 3),
(4, '2024-06-04', 'Pending', '2024-06-11', 4),
(5, '2024-06-05', 'Pending', '2024-06-12', 5);

-- Populate PurchaseOrderDetail table
INSERT INTO PurchaseOrderDetail (PurchaseOrderID, MedicationID, QuantityOrdered, UnitPrice)
VALUES
(1, 1, 10, 2.50),  
(1, 2, 15, 0.50), 
(2, 3, 5, 5.00),  
(2, 4, 20, 1.25),  
(3, 5, 10, 3.00), 
(3, 6, 15, 0.75), 
(4, 7, 20, 1.50),  
(4, 8, 25, 2.00),  
(5, 9, 30, 0.25), 
(5, 10, 40, 1.00); 


-- Update Total_Amount in PurchaseOrder table with a WHERE clause
UPDATE PurchaseOrder po
JOIN (
    SELECT PurchaseOrderID, SUM(Total_Price) AS TotalAmount
    FROM PurchaseOrderDetail
    GROUP BY PurchaseOrderID
) pod ON po.PurchaseOrderID = pod.PurchaseOrderID
SET po.Total_Amount = pod.TotalAmount
WHERE po.PurchaseOrderID IN (SELECT DISTINCT PurchaseOrderID FROM PurchaseOrderDetail);


-- populate Alert step 1:Insert Low Stock Alerts
INSERT INTO Alert (MedicationID, AlertType, AlertDate, Resolved)
SELECT 
    M.MedicationID, 
    'Low Stock' AS AlertType, 
    CURRENT_DATE AS AlertDate, 
    FALSE AS Resolved
FROM 
    Medication M
JOIN 
    Inventory I ON M.MedicationID = I.MedicationID
WHERE 
    I.QuantityInStock <= M.ReorderLevel;

-- step 2: Insert Expired Medication Alerts
INSERT INTO Alert (MedicationID, AlertType, AlertDate, Resolved)
SELECT 
    MedicationID, 
    'Expired' AS AlertType, 
    CURRENT_DATE AS AlertDate, 
    FALSE AS Resolved
FROM 
    Medication
WHERE 
    ExpirationDate < CURRENT_DATE;



-- Populate Employee table
INSERT INTO Employee (EmployeeID, F_name, L_name, Role, ContactNumber, Email)
VALUES
(1, 'Abebe', 'Kebede', 'Pharmacist', '+251987654321', 'abebe.kebede@pharmacy.et'),
(2, 'Biniam', 'Tsegaye', 'Inventory Manager', '+251976543210', 'biniam.tsegaye@pharmacy.et'),
(3, 'Chaltu', 'Bekele', 'Order Processor', '+251965432109', 'chaltu.bekele@pharmacy.et'),
(4, 'Dawit', 'Asrat', 'Pharmacy Technician', '+251954321098', 'dawit.asrat@pharmacy.et'),
(5, 'Eden', 'Mulugeta', 'Pharmacist', '+251943210987', 'eden.mulugeta@pharmacy.et');




-- Query 1: List all Medications with their Supplier Information
SELECT 
    m.MedicationID, 
    m.Name AS MedicationName, 
    m.Category, 
    s.CompanyName AS SupplierName, 
    s.ContactPerson, 
    s.Phone, 
    s.Email, 
    s.City, 
    s.State,
    s.Country
FROM 
    Medication m
JOIN 
Supplier s ON m.SupplierID = s.SupplierID;



-- Query 2: Find Expired Medications
SELECT 
    MedicationID, 
    Name, 
    ExpirationDate
FROM 
    Medication
WHERE 
    ExpirationDate < CURDATE();



-- Query 3: Find Medications that need to be Reordered
SELECT 
    m.MedicationID, 
    m.Name
FROM 
    Medication m
JOIN 
    Inventory i ON m.MedicationID = i.MedicationID
WHERE 
    i.QuantityInStock <= m.ReorderLevel;



-- Query 4: Get all Active Alerts for Medications
SELECT 
    a.AlertID, 
    m.Name AS MedicationName, 
    a.AlertType, 
    a.AlertDate, 
    a.Resolved
FROM 
    Alert a
JOIN 
    Medication m ON a.MedicationID = m.MedicationID
WHERE 
a.Resolved = FALSE;




-- Query 5: Step 1: Insert new purchase orders for medications below reorder level
INSERT INTO PurchaseOrder (OrderDate, Status, ExpectedDeliveryDate, SupplierID)
SELECT CURRENT_DATE, 'Pending', DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY), m.SupplierID
FROM Medication m
JOIN Inventory i ON m.MedicationID = i.MedicationID
WHERE i.QuantityInStock <= m.ReorderLevel;

-- Step 2: Insert new purchase order details with previous unit price
INSERT INTO PurchaseOrderDetail (PurchaseOrderID, MedicationID, QuantityOrdered, UnitPrice)
SELECT 
    po.PurchaseOrderID, 
    m.MedicationID, 
    (m.ReorderLevel * 2) AS QuantityOrdered,  -- Example quantity to order
    (SELECT pod.UnitPrice 
     FROM PurchaseOrderDetail pod 
     WHERE pod.MedicationID = m.MedicationID 
     ORDER BY pod.PurchaseOrderID DESC 
     LIMIT 1) AS UnitPrice 
     -- Fetch the most recent UnitPrice
FROM Medication m
JOIN Inventory i ON m.MedicationID = i.MedicationID
JOIN PurchaseOrder po ON po.SupplierID = m.SupplierID
WHERE i.QuantityInStock <= m.ReorderLevel
AND po.OrderDate = CURRENT_DATE;

-- step 3: Update Total_Amount in PurchaseOrder table with a WHERE clause
UPDATE PurchaseOrder po
JOIN (
    SELECT PurchaseOrderID, SUM(Total_Price) AS TotalAmount
    FROM PurchaseOrderDetail
    GROUP BY PurchaseOrderID
) pod ON po.PurchaseOrderID = pod.PurchaseOrderID
SET po.Total_Amount = pod.TotalAmount
WHERE po.PurchaseOrderID IN (SELECT DISTINCT PurchaseOrderID FROM PurchaseOrderDetail);

-- step 4:Update alerts for medications that are low on stock and have had purchase orders generated
-- Disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- Perform the update
WITH cte AS (
    SELECT a.AlertID
    FROM Alert a
    JOIN Medication m ON a.MedicationID = m.MedicationID
    JOIN Inventory i ON m.MedicationID = i.MedicationID
    WHERE i.QuantityInStock <= m.ReorderLevel
    AND a.AlertType = 'Low Stock'
)
UPDATE Alert
SET Resolved = TRUE
WHERE AlertID IN (SELECT AlertID FROM cte);

-- Re-enable safe update mode
SET SQL_SAFE_UPDATES = 1;




--  Query 6: List all Purchase Orders with their Details
SELECT 
po.PurchaseOrderID, 
m.Name AS MedicationName, 
s.CompanyName AS SupplierName,
    pod.QuantityOrdered, 
    pod.UnitPrice, 
(pod.QuantityOrdered * pod.UnitPrice) AS TotalPrice,
    po.OrderDate, 
po.ExpectedDeliveryDate,
po.Status
FROM 
    PurchaseOrder po
JOIN 
    Supplier s ON po.SupplierID = s.SupplierID
JOIN 
    PurchaseOrderDetail pod ON po.PurchaseOrderID = pod.PurchaseOrderID
JOIN 
    Medication m ON pod.MedicationID = m.MedicationID;




-- Query 7: Get Inventory Details for a Specific Medication
SELECT 
    i.InventoryID, 
    m.Name AS MedicationName, 
    i.QuantityInStock, 
    i.LastUpdated, 
    i.Room, 
    i.Shelf_no
FROM 
    Inventory i
JOIN 
    Medication m ON i.MedicationID = m.MedicationID
WHERE 
    m.Name = 'Paracetamol';





-- Query 8: List All Employees with their Contact Information
SELECT 
    EmployeeID, 
    F_name AS FirstName, 
    L_name AS LastName, 
    ContactNumber, 
    Email
FROM 
    Employee;




-- Query 9: Total Stock Value of Each Medication
SELECT 
    m.MedicationID, 
    m.Name AS MedicationName, 
    SUM(i.QuantityInStock * pod.UnitPrice) AS TotalStockValue
FROM 
    Medication m
JOIN 
    Inventory i ON m.MedicationID = i.MedicationID
JOIN 
    PurchaseOrderDetail pod ON m.MedicationID = pod.MedicationID
GROUP BY 
    m.MedicationID, 
    m.Name;





 -- Query 11: List Suppliers in a Specific City
SELECT 
    SupplierID, 
    CompanyName, 
    ContactPerson, 
    Phone, 
    Email, 
    City, 
    State, 
    Country
FROM 
    Supplier
WHERE 
    City = 'Addis Ababa'; 
