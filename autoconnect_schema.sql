-- CREATE SCHEMA autoconnect;
-- USE autoconnect;
DROP TABLE IF EXISTS Insurance_Details;
DROP TABLE IF EXISTS SoldCars;
DROP TABLE IF EXISTS UsedCars;
DROP TABLE IF EXISTS client_info;
DROP TABLE IF EXISTS Agent;
DROP TABLE IF EXISTS Employee;

-- Create Employee table first
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    DOB DATE NOT NULL,
    Department VARCHAR(255)
);

-- Then create Agent table which references Employee
CREATE TABLE Agent (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(255) NOT NULL,
    region VARCHAR(255) NOT NULL,
    assigned_by VARCHAR(255),
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- Then create client_info table which references Agent
CREATE TABLE client_info (
   client_id INT NOT NULL AUTO_INCREMENT,  -- Make client_id auto-increment
   client_name VARCHAR(255) NOT NULL,
   region VARCHAR(255) NOT NULL,
   preference_type VARCHAR(255) DEFAULT NULL,
   agent_id INT DEFAULT NULL,  -- Foreign key referencing Agent table
   PRIMARY KEY (client_id),
   KEY agent_id (agent_id),
   CONSTRAINT client_info_ibfk_1 FOREIGN KEY (agent_id) REFERENCES Agent (agent_id)
     ON DELETE SET NULL  -- If an agent is deleted, set agent_id in client_info to NULL
     ON UPDATE CASCADE   -- If agent_id is updated, update it in client_info too
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create UsedCars table
CREATE TABLE UsedCars (
    car_id INT PRIMARY KEY,               -- Unique car identifier
    price DECIMAL(10, 2) NOT NULL,         -- Price of the car
    age INTEGER,                           -- Age of the car
    model VARCHAR(255) NOT NULL,           -- Car model
    type VARCHAR(255),                     -- Car type (e.g., sedan, SUV)
    colour VARCHAR(255),                   -- Car color
    miles_driven INTEGER                   -- Miles driven by the car
);


-- Create SoldCars table which references Agent and client_info
CREATE TABLE SoldCars (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,     -- Unique sale identifier
    car_id INT,                                 -- Car identifier (foreign key)
    sold_by VARCHAR(255) NOT NULL,              -- Name of the agent who sold the car
    buyer VARCHAR(255) NOT NULL,                -- Name of the buyer
    sell_price DECIMAL(10, 2) NOT NULL,         -- Sale price
    agent_id INT,                               -- Foreign key to Agent table
    client_id INT,                              -- Foreign key to Client table
    FOREIGN KEY (car_id) REFERENCES UsedCars(car_id), -- Foreign key linking to UsedCars
    FOREIGN KEY (agent_id) REFERENCES Agent(agent_id), -- Foreign key to Agent
    FOREIGN KEY (client_id) REFERENCES client_info(client_id) -- Foreign key to client_info
);
-- Create Insurance_Details table which references SoldCars and client_info
CREATE TABLE Insurance_Details (
    policy_number VARCHAR(50) PRIMARY KEY,
    valid_from DATE NOT NULL,
    valid_till DATE NOT NULL,
    coverage VARCHAR(255) NOT NULL,
    premium INT NOT NULL,
    car_id INT,
    client_id INT,
    FOREIGN KEY (car_id) REFERENCES SoldCars(car_id),
    FOREIGN KEY (client_id) REFERENCES client_info(client_id)
);


INSERT INTO Employee (employee_id, name, DOB, Department) VALUES
(10001, 'Alice Johnson', '1980-05-15', 'Sales'),
(10002, 'Bob Smith', '1982-09-22', 'Finance'),
(10003, 'Charlie Davis', '1985-03-10', 'Marketing'),
(10004, 'David Wilson', '1978-12-18', 'IT'),
(10005, 'Eva Brown', '1989-07-25', 'HR'),
(10006, 'Frank Taylor', '1983-01-30', 'Sales'),
(10007, 'Grace White', '1987-06-12', 'Finance'),
(10008, 'Harry Martin', '1975-11-08', 'Marketing'),
(10009, 'Ivy Lee', '1984-04-05', 'IT'),
(10010, 'Jack Davis', '1990-08-20', 'HR'),
(10011, 'Kathy Taylor', '1981-02-28', 'Sales'),
(10012, 'Leo Smith', '1986-09-15', 'Finance'),
(10013, 'Mia Harris', '1979-04-22', 'Marketing'),
(10014, 'Noah Wilson', '1988-07-05', 'IT'),
(10015, 'Olivia Brown', '1980-12-10', 'HR'),
(10016, 'Paul Martin', '1984-03-18', 'Sales'),
(10017, 'Quinn Davis', '1977-06-25', 'Finance'),
(10018, 'Ryan Lee', '1982-11-30', 'Marketing'),
(10019, 'Sophie White', '1989-04-15', 'IT'),
(10020, 'Tom Harris', '1981-09-08', 'HR'),
(10021, 'Ursula Taylor', '1983-02-14', 'Sales'),
(10022, 'Vincent Smith', '1987-07-28', 'Finance'),
(10023, 'Wendy Davis', '1979-12-05', 'Marketing'),
(10024, 'Xavier Wilson', '1985-05-20', 'IT'),
(10025, 'Yvonne Brown', '1988-10-18', 'HR'),
(10026, 'Zachary Taylor', '1986-03-25', 'Insurance'),
(10027, 'Abby Smith', '1989-08-12', 'Insurance'),
(10028, 'Benjamin Davis', '1978-04-30', 'Insurance'),
(10029, 'Catherine Wilson', '1984-11-15', 'Insurance'),
(10030, 'Daniel Brown', '1982-06-08', 'Insurance');

INSERT INTO Agent (`agent_id`, `agent_name`, `region`, `assigned_by`, `employee_id`) VALUES
(101, 'Alice Johnson', 'North', 'Bob Smith', 10001),
(102, 'Charlie Davis', 'East', 'David Wilson', 10002),
(103, 'Emma Taylor', 'North', 'Frank Brown', 10003),
(104, 'Grace Lee', 'East', 'Harry Martin', 10004),
(105, 'Ivy Miller', 'North', 'Jack Johnson', 10005),
(106, 'Leo Davis', 'East', 'Kathy Harris', 10006),
(107, 'Mia Wilson', 'North', 'Leo Davis', 10007),
(108, 'Noah Smith', 'West', 'Olivia Taylor', 10008),
(109, 'Paul Brown', 'South', 'Quinn Lee', 10009),
(110, 'Ryan Martin', 'West', 'Sophie Miller', 10010),
(111, 'Tom Johnson', 'South', 'Tom Johnson', 10011),
(112, 'Ursula Harris', 'North', 'Vincent Davis', 10012),
(113, 'Wendy Smith', 'East', 'Wendy Smith', 10013),
(114, 'Xavier Brown', 'South', 'Xavier Brown', 10014),
(115, 'Yvonne Taylor', 'North', 'Yvonne Taylor', 10015),
(116, 'Zachary White', 'East', 'Zachary White', 10016),
(117, 'Abigail Martin', 'South', 'Abigail Martin', 10017),
(118, 'Benjamin Harris', 'North', 'Benjamin Harris', 10018),
(119, 'Catherine Davis', 'East', 'Catherine Davis', 10019),
(120, 'Daniel Wilson', 'South', 'Daniel Wilson', 10020);

-- Insert data into the Client table
INSERT INTO client_info (`client_id`, `client_name`, `region`, `preference_type`, `agent_id`) VALUES
(1, 'John Doe', 'North', 'Premium', 101),
(2, 'Jane Smith', 'South', 'Basic', 102),
(3, 'Robert Brown', 'East', 'Standard', 103),
(4, 'Emily Davis', 'West', 'Premium', 104),
(5, 'William Johnson', 'South', 'Basic', 105),
(6, 'Olivia Taylor', 'North', 'Standard', 106),
(7, 'Sophia Martinez', 'East', 'Premium', 107),
(8, 'Jackson Wilson', 'West', 'Basic', 108),
(9, 'Daniel Lee', 'South', 'Standard', 109),
(10, 'Madeline Clark', 'North', 'Premium', 110),
(11, 'Lucas Anderson', 'East', 'Basic', 111),
(12, 'Mason Thomas', 'West', 'Standard', 112),
(13, 'Ella Harris', 'South', 'Premium', 113),
(14, 'Henry White', 'North', 'Basic', 114),
(15, 'Ava Lewis', 'East', 'Standard', 115),
(16, 'Liam Robinson', 'South', 'Premium', 116),
(17, 'Charlotte Walker', 'North', 'Basic', 117),
(18, 'Amelia King', 'East', 'Standard', 118),
(19, 'Ethan Scott', 'West', 'Premium', 119),
(20, 'James Moore', 'South', 'Basic', 120);


INSERT INTO UsedCars (car_id, price, age, model, type, colour, miles_driven)
VALUES
(100001, 15000.00, 3, 'Toyota Camry', 'Sedan', 'Blue', 30000),
(100002, 20000.00, 2, 'Honda Accord', 'Sedan', 'Silver', 25000),
(100003, 18000.00, 4, 'Ford Fusion', 'Sedan', 'Black', 35000),
(100004, 22000.00, 1, 'Chevrolet Malibu', 'Sedan', 'Red', 20000),
(100005, 25000.00, 2, 'Nissan Altima', 'Sedan', 'White', 28000),
(100006, 18000.00, 3, 'Toyota RAV4', 'SUV', 'Green', 32000),
(100007, 23000.00, 2, 'Honda CR-V', 'SUV', 'Silver', 26000),
(100008, 20000.00, 4, 'Ford Escape', 'SUV', 'Blue', 38000),
(100009, 25000.00, 1, 'Chevrolet Equinox', 'SUV', 'Black', 21000),
(100010, 27000.00, 2, 'Nissan Rogue', 'SUV', 'Red', 24000),
(100011, 30000.00, 3, 'Toyota Tacoma', 'Truck', 'White', 35000),
(100012, 32000.00, 2, 'Ford F-150', 'Truck', 'Silver', 28000),
(100013, 28000.00, 4, 'Chevrolet Silverado', 'Truck', 'Black', 40000),
(100014, 35000.00, 1, 'GMC Sierra', 'Truck', 'Blue', 23000),
(100015, 33000.00, 2, 'Ram 1500', 'Truck', 'Red', 26000),
(100016, 29000.00, 3, 'Jeep Wrangler', 'Convertible', 'Yellow', 30000),
(100017, 18000.00, 2, 'Mazda CX-5', 'SUV', 'Orange', 22000),
(100018, 21000.00, 4, 'Hyundai Tucson', 'SUV', 'Gray', 38000),
(100019, 24000.00, 1, 'Kia Sportage', 'SUV', 'Brown', 18000),
(100020, 26000.00, 2, 'Subaru Outback', 'SUV', 'Purple', 25000);



-- Insert data into SoldCars table
INSERT INTO SoldCars (sale_id, car_id, sold_by, buyer, sell_price, agent_id, client_id)
VALUES
(1, 100001, 'Alice Johnson', 'John Doe', 14500.00, 101, 1),
(2, 100002, 'Charlie Davis', 'Jane Smith', 19000.00, 102, 2),
(3, 100003, 'Emma Taylor', 'George Brown', 17500.00, 103, 3),
(4, 100004, 'Grace Lee', 'Linda White', 21000.00, 104, 4),
(5, 100005, 'Ivy Miller', 'Michael Green', 24000.00, 105, 5),
(6, 100006, 'Leo Davis', 'Sarah Harris', 18000.00, 106, 6),
(7, 100007, 'Mia Wilson', 'Emily Lee', 22500.00, 107, 7),
(8, 100008, 'Noah Smith', 'David Clark', 20000.00, 108, 8),
(9, 100009, 'Paul Brown', 'Oliver Davis', 25000.00, 109, 9),
(10, 100010, 'Ryan Martin', 'Sophia Taylor', 27000.00, 110, 10),
(11, 100011, 'Tom Johnson', 'Joshua Evans', 29500.00, 111, 11),
(12, 100012, 'Ursula Harris', 'Benjamin Lewis', 31500.00, 112, 12),
(13, 100013, 'Wendy Smith', 'Chloe Moore', 28000.00, 113, 13),
(14, 100014, 'Xavier Brown', 'Ava Martin', 33000.00, 114, 14),
(15, 100015, 'Yvonne Taylor', 'Ethan White', 32000.00, 115, 15),
(16, 100016, 'Zachary White', 'Lily Allen', 29000.00, 116, 16),
(17, 100017, 'Abigail Martin', 'Mason Harris', 20000.00, 117, 17),
(18, 100018, 'Benjamin Harris', 'Amelia King', 21000.00, 118, 18),
(19, 100019, 'Catherine Davis', 'Jacob Clark', 23500.00, 119, 19),
(20, 100020, 'Daniel Wilson', 'Madison Walker', 25500.00, 120, 20);


INSERT INTO Insurance_Details (policy_number, valid_from, valid_till, coverage, premium, car_id, client_id)
VALUES
(1001, '2023-01-01', '2024-01-01', 'Comprehensive', 500.00, 100001, 1),
(1002, '2023-02-01', '2024-02-01', 'Third Party', 300.00, 100002, 2),
(1003, '2023-03-01', '2024-03-01', 'Comprehensive', 550.00, 100003, 3),
(1004, '2023-04-01', '2024-04-01', 'Third Party', 320.00, 100004, 4),
(1005, '2023-05-01', '2024-05-01', 'Comprehensive', 520.00, 100005, 5),
(1006, '2023-06-01', '2024-06-01', 'Third Party', 300.00, 100006, 6),
(1007, '2023-07-01', '2024-07-01', 'Comprehensive', 600.00, 100007, 7),
(1008, '2023-08-01', '2024-08-01', 'Third Party', 350.00, 100008, 8),
(1009, '2023-09-01', '2024-09-01', 'Comprehensive', 580.00, 100009, 9),
(1010, '2023-10-01', '2024-10-01', 'Third Party', 320.00, 100010, 10),
(1011, '2023-11-01', '2024-11-01', 'Comprehensive', 530.00, 100011, 11),
(1012, '2023-12-01', '2024-12-01', 'Third Party', 300.00, 100012, 12),
(1013, '2024-01-01', '2025-01-01', 'Comprehensive', 600.00, 100013, 13),
(1014, '2024-02-01', '2025-02-01', 'Third Party', 350.00, 100014, 14),
(1015, '2024-03-01', '2025-03-01', 'Comprehensive', 550.00, 100015, 15),
(1016, '2024-04-01', '2025-04-01', 'Third Party', 320.00, 100016, 16),
(1017, '2024-05-01', '2025-05-01', 'Comprehensive', 520.00, 100017, 17),
(1018, '2024-06-01', '2025-06-01', 'Third Party', 300.00, 100018, 18),
(1019, '2024-07-01', '2025-07-01', 'Comprehensive', 580.00, 100019, 19),
(1020, '2024-08-01', '2025-08-01', 'Third Party', 350.00, 100020, 20);
