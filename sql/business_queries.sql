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
