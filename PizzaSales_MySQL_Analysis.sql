-- Pizza sales data analysis
SELECT * FROM portfolio_project.pizza_sales;

-- Finding total revenue
SELECT SUM(total_price) AS total_revenue
FROM `portfolio_project`.`pizza_sales`;

-- Finding average amount spent per order
SELECT TRUNCATE(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS avg_amount_per_order
FROM `portfolio_project`.`pizza_sales`;

-- Finding total amount pizzas sold
SELECT SUM(quantity) AS total_pizza_sold
FROM `portfolio_project`.`pizza_sales`;

-- Finding total amount of orders placed
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM `portfolio_project`.`pizza_sales`;

-- Finding average amount pizzas per order
SELECT TRUNCATE(SUM(quantity) / COUNT(DISTINCT order_id), 2) AS avg_amount_pizzas_per_order
FROM `portfolio_project`.`pizza_sales`;

-- Finding daily order trends
SELECT DATE_FORMAT(order_date, '%W') AS order_day, COUNT(DISTINCT order_id) AS total_orders_per_day
FROM `portfolio_project`.`pizza_sales`
GROUP BY order_day
ORDER BY total_orders_per_day DESC;

-- Finding hourly order trends
SELECT TIME_FORMAT(order_time, '%H') AS order_hour, COUNT(DISTINCT order_id) AS total_orders_per_hour
FROM `portfolio_project`.`pizza_sales`
GROUP BY order_hour
ORDER BY order_hour;

-- Finding total amount pizzas sold by category 
SELECT pizza_category, SUM(quantity) AS total_per_category
FROM `portfolio_project`.`pizza_sales`
GROUP BY pizza_category
ORDER BY total_per_category DESC;

-- Finding total sales per pizza category
SELECT pizza_category, TRUNCATE(SUM(total_price), 2) AS total_sales_per_category
FROM `portfolio_project`.`pizza_sales`
GROUP BY pizza_category;

-- Finding percentage pizzas sold by category
SELECT pizza_category, TRUNCATE(SUM(total_price) * 100  / (SELECT SUM(total_price) FROM `portfolio_project`.`pizza_sales`), 2) AS percentage_pizzas_sold_per_category
FROM `portfolio_project`.`pizza_sales`
GROUP BY pizza_category;

-- Finding total pizzas sold per size
SELECT pizza_size, SUM(quantity) AS total_per_size
FROM `portfolio_project`.`pizza_sales`
GROUP BY pizza_size
ORDER BY total_per_size DESC;

-- Finding total sales per pizza size
SELECT pizza_size, TRUNCATE(SUM(total_price), 2) AS total_sales_per_size
FROM `portfolio_project`.`pizza_sales`
GROUP BY pizza_size;

-- Finding percentage pizzas sold by size
SELECT pizza_size, TRUNCATE(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM `portfolio_project`.`pizza_sales`), 2) AS percentage_pizzas_sold_per_size
FROM `portfolio_project`.`pizza_sales`
GROUP BY pizza_size
ORDER BY percentage_pizzas_sold_per_size DESC;

-- Finding top 5 sellers
SELECT pizza_name, SUM(quantity) AS total_pizzas_sold
FROM `portfolio_project`.`pizza_sales`
GROUP BY pizza_name
ORDER BY total_pizzas_sold DESC
LIMIT 5;

-- Finding bottom 5 sellers
SELECT pizza_name, SUM(quantity) AS total_pizzas_sold
FROM `portfolio_project`.`pizza_sales`
GROUP BY pizza_name
ORDER BY total_pizzas_sold
LIMIT 5;