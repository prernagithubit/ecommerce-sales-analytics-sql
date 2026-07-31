USE ecommerce_analytics;
#Total revenue 
SELECT
        SUM(total_amount) AS total_revenue
FROM orders
WHERE order_status = 'Delivered';

# Query 2: Top 5 Best-Selling Products

SELECT
    p.product_name,
    SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY
    total_units_sold DESC
LIMIT 5;

-- Query 3: Top 5 Customers by Total Spending
SELECT 
    c.customer_id,
    CONCAT(c.first_name,'',c.last_name) AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c 
JOIN orders o 
    ON c.customer_name = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY 
    c.customer_id,
    c.customer_name,
    c.last_name
ORDER BY 
    total_spent DESC 
LIMIT 5;    

