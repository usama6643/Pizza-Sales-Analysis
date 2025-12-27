select * from pizza;
CREATE TABLE pizza (
    pizza_id INT,
    order_id INT,
    pizza_name_id INT,
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price DECIMAL(6,2),
    total_price DECIMAL(8,2),
    pizza_size VARCHAR(10),
    pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100)
);
--
ALTER TABLE pizza
ALTER COLUMN pizza_name_id TYPE VARCHAR(50);
SET datestyle = DMY;
--

COPY pizza
FROM 'E:/pizza_sales.csv'
DELIMITER ','
CSV HEADER;
--1. Total Revenue
select sum(total_price) as total_revenue from pizza;
--2. Average Order Value
SELECT 
    SUM(total_price) / count(DISTINCT order_id) AS avg_order_value
FROM pizza;

SELECT 
    SUM(total_price) / su( quantity) AS avg_order_value
FROM pizza;
--Total pizza sold
select sum(quantity) as Total_pizza_sold from pizza
--Total Orders
select count(distinct(order_id)) as Total_order from pizza
--Average pizza per order
select sum (quantity) / count(distinct (order_id)) from pizza
--Daily Trend for Total Orders
SELECT 
  TO_CHAR(order_date, 'Day') AS order_day,
  COUNT(DISTINCT order_id) AS total_orders
FROM pizza
GROUP BY TO_CHAR(order_date, 'Day');
-- Hourly Trend Query:
SELECT 
  EXTRACT(HOUR FROM order_time) AS hour,
  COUNT(order_id) AS total_orders
FROM pizza
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY hour;
-- % of Sales by Pizza Category
select pizza_category,sum(total_price) as Total_Sales ,sum(Total_price)*100/ (select sum(total_price) from pizza) as PT
from pizza
group by pizza_category
--  % of Sales by Pizza size
select pizza_size,sum(total_price) as Total_Sales,sum(total_price)*100/ (select sum(total_price) from pizza) as PS
from pizza
group by pizza_size
--Total pizza sold by pizza category
select pizza_category,sum(quantity) as total_pizza
from pizza
group by pizza_category
--Top 5 best seller by total pizza sold
select pizza_name,sum(quantity) as TOP_SELLER
from pizza
group by pizza_name
order by sum(quantity) desc
limit 5














