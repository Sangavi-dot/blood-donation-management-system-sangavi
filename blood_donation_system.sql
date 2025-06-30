
-- Database: BloodDonationDB

-- Drop tables if they exist
DROP TABLE IF EXISTS Donations, BloodInventory, Recipients, Donors;

-- Donors Table
CREATE TABLE Donors (
    DonorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    BloodGroup VARCHAR(5),
    Contact VARCHAR(15),
    LastDonationDate DATE
);

-- Recipients Table
CREATE TABLE Recipients (
    RecipientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    BloodGroup VARCHAR(5),
    Contact VARCHAR(15),
    BloodRequired INT
);

-- Blood Inventory Table
CREATE TABLE BloodInventory (
    BloodGroup VARCHAR(5) PRIMARY KEY,
    UnitsAvailable INT
);

-- Donations Table
CREATE TABLE Donations (
    DonationID INT AUTO_INCREMENT PRIMARY KEY,
    DonorID INT,
    BloodGroup VARCHAR(5),
    DonationDate DATE,
    FOREIGN KEY (DonorID) REFERENCES Donors(DonorID)
);

-- Sample Data

-- Donor Registration
INSERT INTO Donors (Name, Age, BloodGroup, Contact, LastDonationDate)
VALUES ('Rahul Sharma', 28, 'O+', '9876543210', '2025-03-01');

-- Recipient Registration
INSERT INTO Recipients (Name, Age, BloodGroup, Contact, BloodRequired)
VALUES ('Aditi Verma', 35, 'O+', '9898989898', 2);

-- Initial Blood Inventory
INSERT INTO BloodInventory (BloodGroup, UnitsAvailable) VALUES
('O+', 5),
('A+', 5),
('B+', 3),
('AB+', 6),
('O-', 2),
('A-', 1);

-- Donation Entry
INSERT INTO Donations (DonorID, BloodGroup, DonationDate)
VALUES (1, 'O+', '2025-03-20');

-- Trigger for automatic stock update after donation
DELIMITER //
CREATE TRIGGER AfterDonationInsert
AFTER INSERT ON Donations
FOR EACH ROW
BEGIN
    UPDATE BloodInventory
    SET UnitsAvailable = UnitsAvailable + 1
    WHERE BloodGroup = NEW.BloodGroup;
END;
//
DELIMITER ;
