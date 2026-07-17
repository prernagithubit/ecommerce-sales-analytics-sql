USE ecommerce_analytics;

INSERT INTO categories (category_name, description)
VALUES
('Electronics', 'Electronic devices and accessories'),
('Clothing', 'Fashion and apparel products'),
('Home & Kitchen', 'Products for home and kitchen'),
('Books', 'Books and educational materials'),
('Beauty', 'Beauty and personal care products');

INSERT INTO customers
(first_name, last_name, email, phone, gender, date_of_birth, city, state, country)
VALUES
('Aarav', 'Sharma', 'aarav.sharma@email.com', '9876543210', 'Male', '1998-05-12', 'Delhi', 'Delhi', 'India'),
('Priya', 'Verma', 'priya.verma@email.com', '9876543211', 'Female', '1999-08-20', 'Mumbai', 'Maharashtra', 'India'),
('Rahul', 'Gupta', 'rahul.gupta@email.com', '9876543212', 'Male', '1997-03-15', 'Bengaluru', 'Karnataka', 'India'),
('Ananya', 'Singh', 'ananya.singh@email.com', '9876543213', 'Female', '2000-11-02', 'Pune', 'Maharashtra', 'India'),
('Vikram', 'Patel', 'vikram.patel@email.com', '9876543214', 'Male', '1996-07-25', 'Ahmedabad', 'Gujarat', 'India'),
('Sneha', 'Mehta', 'sneha.mehta@email.com', '9876543215', 'Female', '1998-01-18', 'Hyderabad', 'Telangana', 'India'),
('Rohan', 'Malhotra', 'rohan.malhotra@email.com', '9876543216', 'Male', '1995-09-30', 'Chennai', 'Tamil Nadu', 'India'),
('Kavya', 'Reddy', 'kavya.reddy@email.com', '9876543217', 'Female', '2001-04-10', 'Kolkata', 'West Bengal', 'India'),
('Aditya', 'Kumar', 'aditya.kumar@email.com', '9876543218', 'Male', '1999-12-05', 'Noida', 'Uttar Pradesh', 'India'),
('Ishita', 'Joshi', 'ishita.joshi@email.com', '9876543219', 'Female', '1997-06-22', 'Jaipur', 'Rajasthan', 'India');

INSERT INTO products
(product_name, category_id, price, stock_quantity, product_rating)
VALUES
('Wireless Headphones', 1, 2999.00, 50, 4.5),
('Smartphone', 1, 24999.00, 30, 4.3),
('Laptop', 1, 64999.00, 20, 4.7),
('Smart Watch', 1, 5999.00, 40, 4.2),
('Cotton T-Shirt', 2, 799.00, 100, 4.1),
('Denim Jeans', 2, 1999.00, 75, 4.4),
('Running Shoes', 2, 2999.00, 60, 4.6),
('Coffee Maker', 3, 4499.00, 25, 4.3),
('Non-Stick Cookware Set', 3, 3499.00, 35, 4.5),
('SQL Programming Book', 4, 899.00, 80, 4.8),
('Python Data Science Book', 4, 1299.00, 65, 4.7),
('Face Moisturizer', 5, 599.00, 90, 4.2);cd ~/Documents/ecommerce-sales-analytics-sql
