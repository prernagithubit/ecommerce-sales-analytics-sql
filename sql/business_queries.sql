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
-- Query 4: Monthly Sales Trend
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(total_amount) AS revenue
FROM orders 
WHERE order_status = 'Delivered'
GROUP BY 
    YEAR (order_date)
    MONTH(order_date)
ORDER BY 
    year,
    month;    

-- Query 5: Top Categories by Revenue

SELECT
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY
    c.category_id,
    c.category_name
ORDER BY
    total_revenue DESC;

-- Query 6: Products Never Ordered

SELECT
    p.product_id,
    p.product_name,
    p.price
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;

-- Query 7: Average Order Value (AOV)

SELECT
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE order_status = 'Delivered';


-- Query 8: Payment Method Analysis

SELECT
    payment_method,
    COUNT(payment_id) AS total_transactions,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS average_transaction_value
FROM payments
WHERE payment_status = 'Completed'
GROUP BY payment_method
ORDER BY total_revenue DESC;


-- Query 9: Customer Lifetime Value (CLV)

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS lifetime_value,
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY
    lifetime_value DESC;

-- Query 10: Top 5 Cities by Revenue

SELECT
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY
    c.city
ORDER BY
    total_revenue DESC
LIMIT 5;

-- Query 11: Customer Segmentation

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS total_spent,
    CASE
        WHEN SUM(o.total_amount) >= 50000 THEN 'Gold'
        WHEN SUM(o.total_amount) >= 10000 THEN 'Silver'
        ELSE 'Bronze'
    END AS customer_segment
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY
    total_spent DESC;

-- Query 13: Monthly Running Revenue

WITH monthly_sales AS (
    SELECT
        YEAR(order_date) AS sales_year,
        MONTH(order_date) AS sales_month,
        SUM(total_amount) AS monthly_revenue
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY
        YEAR(order_date),
        MONTH(order_date)
)

SELECT
    sales_year,
    sales_month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY sales_year, sales_month
    ) AS running_revenue
FROM monthly_sales;

-- Query 14: Month-over-Month Revenue Growth

WITH monthly_sales AS (
    SELECT
        YEAR(order_date) AS sales_year,
        MONTH(order_date) AS sales_month,
        SUM(total_amount) AS monthly_revenue
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY
        YEAR(order_date),
        MONTH(order_date)
)

SELECT
    sales_year,
    sales_month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (
        ORDER BY sales_year, sales_month
    ) AS previous_month_revenue,
    monthly_revenue -
    LAG(monthly_revenue) OVER (
        ORDER BY sales_year, sales_month
    ) AS revenue_difference
FROM monthly_sales;

-- Query 15: Top 3 Products in Each Category

WITH product_sales AS (
    SELECT
        c.category_name,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY c.category_name
            ORDER BY SUM(oi.quantity * oi.unit_price) DESC
        ) AS product_rank
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    JOIN categories c
        ON p.category_id = c.category_id
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        c.category_name,
        p.product_name
)

SELECT
    category_name,
    product_name,
    total_revenue,
    product_rank
FROM product_sales
WHERE product_rank <= 3
ORDER BY
    category_name,
    product_rank;

-- Query 16: ABC Product Analysis

WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY
        p.product_id,
        p.product_name
),

revenue_analysis AS (
    SELECT
        product_id,
        product_name,
        total_revenue,

        SUM(total_revenue) OVER (
            ORDER BY total_revenue DESC
        ) AS cumulative_revenue,

        SUM(total_revenue) OVER () AS overall_revenue
    FROM product_revenue
)

SELECT
    product_id,
    product_name,
    total_revenue,

    ROUND(
        total_revenue / overall_revenue * 100,
        2
    ) AS revenue_percentage,

    ROUND(
        cumulative_revenue / overall_revenue * 100,
        2
    ) AS cumulative_percentage,

    CASE
        WHEN cumulative_revenue / overall_revenue <= 0.80
            THEN 'A'
        WHEN cumulative_revenue / overall_revenue <= 0.95
            THEN 'B'
        ELSE 'C'
    END AS abc_class

FROM revenue_analysis
ORDER BY total_revenue DESC;