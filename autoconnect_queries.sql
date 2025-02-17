-- List agents along with the count of cars sold by each agent:
SELECT a.agent_id,a.agent_name, COUNT(s.car_id) AS cars_sold 
FROM Agent a
LEFT JOIN SoldCars s ON a.agent_id = s.agent_id
 GROUP BY a.agent_id;
 
-- Find the total number of cars sold in each region:
SELECT a.region, COUNT(s.car_id) AS cars_sold 
FROM Agent a
LEFT JOIN SoldCars s ON a.agent_id = s.agent_id 
GROUP BY a.region;

-- Find the youngest and oldest employees in each department:
SELECT Department, MIN(DOB) AS youngest_employee, MAX(DOB) AS oldest_employee 
FROM Employee 
GROUP BY Department;

-- Find clients who have purchased a car and their insurance details: 
SELECT c.client_id, s.buyer,i.policy_number, i.coverage
FROM client_info c
JOIN SoldCars s ON c.client_id = s.client_id
JOIN insurance_details i ON s.car_id = i.car_id;

-- Client Preferences and Their Sold Cars Details
SELECT c.client_name,c.preference_type,u.model AS car_model,u.type AS car_type,s.sell_price,i.coverage AS insurance_coverage
FROM client_info c
JOIN SoldCars s ON c.client_id = s.client_id
JOIN UsedCars u ON s.car_id = u.car_id
JOIN Insurance_Details i ON s.car_id = i.car_id
WHERE c.preference_type = 'Premium'  -- Change preference here if needed
ORDER BY c.client_name;
    
-- Sales Performance of Agents in Different Regions

SELECT 
a.agent_name,a.region,COUNT(s.sale_id) AS total_sales,SUM(s.sell_price) AS total_sales_amount
FROM SoldCars s
JOIN Agent a ON s.agent_id = a.agent_id
GROUP BY a.agent_name, a.region
ORDER BY total_sales_amount DESC;

-- Insurance Premiums vs Car Prices

SELECT i.coverage AS insurance_coverage,AVG(i.premium) AS avg_premium,AVG(s.sell_price) AS avg_car_price
FROM Insurance_Details i
JOIN SoldCars s ON i.car_id = s.car_id
GROUP BY i.coverage
ORDER BY avg_car_price DESC;


