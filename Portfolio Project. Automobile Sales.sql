
SELECT *
FROM auto_sales.sales;

-- Find the list of products in the product_line

SELECT  product_line, COUNT(product_line) AS stock 
FROM auto_sales.sales
GROUP BY product_line
ORDER BY stock DESC;


-- Find our biggest clients and their location

SELECT product_line, quantity_ordered, customer_name, deal_size, country, city
FROM auto_sales.sales
WHERE deal_size = 'Large'
ORDER BY quantity_ordered DESC;


SELECT product_line, price_each, country, city, customer_name, deal_size,
MAX(quantity_ordered) AS quantity
FROM auto_sales.sales
GROUP BY product_line, price_each, country, city, customer_name, deal_size
HAVING deal_size LIKE 'large'
ORDER BY quantity DESC;


-- Find our medium clients and their location

SELECT product_line, price_each, country, city, customer_name, deal_size,
MAX(quantity_ordered) AS quantity
FROM auto_sales.sales
GROUP BY product_line, price_each, country, city, customer_name, deal_size
HAVING deal_size LIKE 'medium'
ORDER BY quantity DESC;

-- Find our smallest clients and their location


SELECT product_line, country, city, customer_name, deal_size,
MIN(quantity_ordered) AS quantity
FROM auto_sales.sales
GROUP BY product_line, country, city, customer_name, deal_size
HAVING deal_size LIKE 'small'
ORDER BY quantity ;



-- Find the best sales year in terms of order size

SELECT order_date, product_line, deal_size, MAX(quantity_ordered) AS best_year
FROM auto_sales.sales
GROUP BY order_date, product_line, deal_size
ORDER BY best_year DESC 
LIMIT 5;

-- Find the best sales year interms of revenue

SELECT price_each * quantity_ordered AS revenue, product_line, order_date
FROM auto_sales.sales
ORDER BY revenue DESC
LIMIT 10;

-- Find the country with the highest orders
 
SELECT country, MAX(quantity_ordered) AS highest_order
FROM auto_sales.sales
GROUP BY country
ORDER BY highest_order DESC
LIMIT 5; 


-- Find the country with the lowest order

SELECT country, MIN(quantity_ordered) AS lowest_order
FROM auto_sales.sales
GROUP BY country
ORDER BY lowest_order
LIMIT 5 ; 

-- FInd the country with the most total orders

SELECT country, SUM(quantity_ordered) AS total_orders
FROM auto_sales.sales
GROUP BY country
ORDER BY total_orders DESC
LIMIT 5;


-- Find the most shipped product

SELECT product_line, `status`, SUM(quantity_ordered) AS total_shipped
FROM auto_sales.sales
WHERE `status` = 'shipped'
GROUP BY product_line
ORDER BY total_shipped DESC;
	
							
-- Find the most profitable product. 

SELECT product_line, 
	SUM(( msrp - quantity_ordered ) * price_each) AS total_profit
FROM auto_sales.sales
GROUP BY product_line
ORDER BY total_profit DESC
 ;


-- Find the most disputed product

SELECT product_line, `status`, SUM(quantity_ordered) AS total_disputed
FROM auto_sales.sales
WHERE `status` = 'disputed'
GROUP BY product_line
ORDER BY total_disputed DESC;


-- Find the customer with the lowest order frequency

SELECT customer_name, COUNT(days_since_last_order) AS order_frequency
FROM auto_sales.sales
GROUP BY customer_name
ORDER BY order_frequency;

SELECT customer_name, COUNT(days_since_last_order) AS order_frequency
FROM auto_sales.sales
GROUP BY customer_name
HAVING order_frequency = (
	SELECT MIN(order_count)
    FROM (
		SELECT COUNT(days_since_last_order) AS order_count
        FROM auto_sales.sales
        GROUP BY customer_name
	) AS subquery
)
ORDER BY customer_name;



-- Find the customer with the highest order frequency

SELECT customer_name, COUNT(days_since_last_order) AS order_frequency
FROM auto_sales.sales
GROUP BY customer_name
ORDER BY order_frequency DESC;

SELECT customer_name, COUNT(days_since_last_order) AS order_frequency
FROM auto_sales.sales
GROUP BY customer_name
HAVING order_frequency = (
	SELECT MAX(order_count)
    FROM (
		SELECT COUNT(days_since_last_order) AS order_count
        FROM auto_sales.sales
        GROUP BY customer_name
	) AS subquery
)
ORDER BY customer_name;


-- Find the product_line with the highest order frequency

SELECT product_line , order_date, COUNT(days_since_last_order) AS order_frequency
FROM auto_sales.sales
GROUP BY product_line, order_date
ORDER BY order_frequency DESC 
;

-- Find the country with the most customers

SELECT country, COUNT(customer_name) AS total_customers
FROM auto_sales.sales
GROUP BY country
ORDER BY total_customers DESC
LIMIT 5;

-- Find the country with the least customers

SELECT country, COUNT(customer_name) AS total_customers
FROM auto_sales.sales
GROUP BY country
ORDER BY total_customers 
LIMIT 5;


-- FInd the product_line with the most orders

SELECT product_line, SUM(quantity_ordered) AS total_orders
FROM auto_sales.sales
GROUP BY product_line
ORDER BY total_orders DESC;