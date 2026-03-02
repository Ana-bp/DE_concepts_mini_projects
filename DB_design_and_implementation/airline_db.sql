/*I work for an airline, and wet leases are a commom thing. With this assignment, to analyze the distribution 
of flights between the different lease companies and the performance of each one's operations.*/

/*CREATE DATABASE Airline;

USE Airline;

CREATE TABLE Wetlease (
	Aircraft_id INT PRIMARY KEY AUTO_INCREMENT,
    Company VARCHAR(15) NOT NULL,
    Start_date DATE NOT NULL,
    End_date DATE NOT NULL);
    
CREATE TABLE Flight_manifest (
	Aircraft_id INT NOT NULL,
    Carrier VARCHAR(2) NOT NULL,
    Flight VARCHAR(4) PRIMARY KEY,
    Dept_date DATE NOT NULL,
    Dept_airport VARCHAR(3) NOT NULL,
    Arrv_airport VARCHAR(3) NOT NULL);

CREATE TABLE Daily_report (
	Aircraft_id INT NOT NULL,
    Flight VARCHAR(4) PRIMARY KEY,
    Sched_time TIME,
    Dept_time TIME);
    
CREATE TABLE Carrier_name (
	Carrier VARCHAR(2) PRIMARY KEY,
    Name_id VARCHAR(30) UNIQUE);
    

ALTER TABLE Daily_report ADD COLUMN Delay TIME;


INSERT INTO Carrier_name (Carrier, Name_id)
VALUES
	("W4", "Wizz Malta"),
    ("W9", "Wizz UK"),
    ("W6", "Wizz Hungary"),
    ("5W", "Wizz Abu Dhabi");
    
INSERT INTO Wetlease (Company, Start_date, End_date)
VALUES
	("Avion", "2024-08-17", "2024-10-26"),
    ("Avion", "2024-08-17", "2024-10-26"),
    ("Privilege", "2024-08-17", "2024-10-31"),
    ("GetJet", "2024-08-17", "2024-09-17"),
    ("SkyUp", "2024-08-17", "2024-11-01"),
    ("SkyUp", "2024-08-17", "2024-11-01"),
    ("Avion", "2024-08-17", "2024-10-26"),
    ("Privilege", "2024-08-17", "2024-10-31");

INSERT INTO Flight_manifest (Aircraft_id, Carrier, Flight, Dept_date, Dept_airport, Arrv_airport)
VALUES
	(1, "W6", "1975", "2024-10-01", "BUD", "TIA"),
    (1, "W6", "1976", "2024-10-01", "TIA", "BUD"),
    (2, "W6", "1890", "2024-10-01", "PDG", "HMB"),
    (3, "W9", "6001", "2024-10-01", "LTN", "CGN"),
    (3, "W9", "6002", "2024-10-01", "CGN", "LTN"),
    (5, "W4", "3141", "2024-10-01", "MXP", "TIA"),
    (5, "W4", "3142", "2024-10-01", "TIA", "MXP"),
    (4, "W4", "4550", "2024-10-01", "FCO", "CGN"),
    (4, "W4", "4551", "2024-10-01", "CGN", "FCO"),
    (6, "W6", "2332", "2024-10-01", "VCE", "BUD"),
    (6, "W6", "2333", "2024-10-01", "BUD", "VCE"),
    (7, "5W", "7049", "2024-10-01", "AUH", "LTN"),
    (7, "5W", "7050", "2024-10-01", "LTN", "AUH"),
    (8, "W9", "5075", "2024-10-01", "LGW", "MXP"),
    (8, "W9", "5076", "2024-10-01", "MXP", "LGW");
    
INSERT INTO Daily_report (Aircraft_id, Flight, Sched_time, Dept_time)
VALUES
	(1, "1975", "19:00", "19:30"),
    (1, "1976", "22:00", "23:00"),
    (2, "1890", "06:00", "14:00"),
    (3, "6001", "10:00", "13:00"),
    (3, "6002", "15:00", "18:00"),
    (5, "3141", "04:00", "04:00"),
    (5, "3142", "07:30", "08:10"),
    (4, "4550", "11:45", "12:00"),
    (4, "4551", "14:15", "15:00"),
    (6, "2332", "03:30", "03:45"),
    (6, "2333", "16:25", "16:25"),
    (7, "7049", "13:05", "13:40"),
    (7, "7050", "15:00", "23:00"),
    (8, "5075", "17:00", "22:00"),
    (8, "5076", "19:00", "23:50");

UPDATE Daily_report
SET Delay = TIMEDIFF(Dept_time, Sched_time) WHERE Flight <> "";


ALTER TABLE Flight_manifest
ADD CONSTRAINT FK_aircraft_id1
FOREIGN KEY (Aircraft_id) REFERENCES Wetlease(Aircraft_id);

ALTER TABLE Daily_report
ADD CONSTRAINT FK_aircraft_id2
FOREIGN KEY (Aircraft_id) REFERENCES Wetlease(Aircraft_id);

ALTER TABLE Flight_manifest
ADD CONSTRAINT FK_carrier
FOREIGN KEY (Carrier) REFERENCES Carrier_name(Carrier);

ALTER TABLE Daily_report
ADD CONSTRAINT FK_flight
FOREIGN KEY (Flight) REFERENCES Flight_manifest(Flight);


#Deleting the flights from the daily report which the wet lease is already over.
#Created as a stored procedure, so it can be reused to clean the rows that contains flights that are not in a lease agreement anymore
DELIMITER //
CREATE PROCEDURE check_expired()
BEGIN
    DELETE dr
    FROM Daily_report dr
    JOIN Wetlease wl ON dr.Aircraft_id = wl.Aircraft_id 
    WHERE wl.End_date < NOW();
END //
DELIMITER ;

CALL check_expired();
*/

#Print which flights will be operated by each lease company
SELECT fm.Carrier, dr.Flight, wl.Company
FROM Daily_report dr
JOIN Wetlease wl 
JOIN Flight_manifest fm 
ON dr.Aircraft_id = wl.Aircraft_id AND dr.Flight = fm.Flight;

#Print how many flights each company is operating
SELECT wl.Company, COUNT(dr.Flight) AS Flights
FROM Daily_report dr
JOIN Wetlease wl ON dr.Aircraft_id = wl.Aircraft_id
GROUP BY wl.Company;

#Print how many flights are delayed more than 30 minutes
SELECT COUNT(dr.Flight) AS Delayed_flights
FROM Daily_report dr
WHERE dr.Delay >= "00:30";

#Print the flights that are delayed more than 30 minutes and the respective company
SELECT fm.Carrier, dr.Flight, dr.Delay, wl.Company
FROM Daily_report dr
JOIN Flight_manifest fm 
JOIN Wetlease wl
ON dr.Flight = fm.Flight AND dr.Aircraft_id = wl.Aircraft_id
WHERE dr.Delay >= "00:30";

#Print the delayed flights per company
SELECT wl.Company, COUNT(dr.Flight) AS Delayed_flights
FROM Daily_report dr
JOIN Wetlease wl ON dr.Aircraft_id = wl.Aircraft_id
WHERE dr.Delay >= "00:30"
GROUP BY wl.Company;

#Print the biggest delay in operations
SELECT MAX(dr.Delay) AS Biggest_delay
FROM Daily_report dr;

#Order Wetlease table based on the end date of the lease agreement
SELECT wl.* FROM Wetlease wl
ORDER BY wl.End_date;

#Order the daily report table based on the delay (descending order)
SELECT dr.* FROM Daily_report dr
ORDER BY dr.Delay DESC;








    