-- ============================================
-- QUESTION 1: Transform ProductDetail into 1NF
-- ============================================

-- Original Table (not in 1NF):
-- OrderID | CustomerName | Products
-- -----------------------------------------
-- 101     | John Doe     | Laptop, Mouse
-- 102     | Jane Smith   | Tablet, Keyboard, Mouse
-- 103     | Emily Clark  | Phone
--
-- Problem:
-- - The Products column contains multiple values (not atomic).
-- - This violates 1NF (First Normal Form).
--
-- Solution:
-- - Break down the Products column so that each row contains only ONE product.
-- - This gives us a clean, atomic structure.

-- Step 1: Create a new normalized table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Step 2: Insert data in atomic form (one product per row)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- ✅ Result: Each row now represents a single product → Table is in 1NF.


-- ============================================
-- QUESTION 2: Transform OrderDetails into 2NF
-- ============================================

-- Original Table (already in 1NF but not in 2NF):
-- OrderID | CustomerName | Product   | Quantity
-- ------------------------------------------------
-- 101     | John Doe     | Laptop    | 2
-- 101     | John Doe     | Mouse     | 1
-- 102     | Jane Smith   | Tablet    | 3
-- 102     | Jane Smith   | Keyboard  | 1
-- 102     | Jane Smith   | Mouse     | 2
-- 103     | Emily Clark  | Phone     | 1
--
-- Problem:
-- - CustomerName depends only on OrderID (not on the full composite key).
-- - This is a partial dependency, which violates 2NF.
--
-- Solution:
-- - Separate customer/order info into an Orders table.
-- - Keep product details in OrderDetails_2NF table.
-- - Use OrderID as the foreign key to link them.

-- Step 1: Create Orders table (removes partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create OrderDetails_2NF table (stores product info)
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert data into Orders (one row per order)
INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 4: Insert product details into OrderDetails_2NF
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- ✅ Result:
-- - Orders table stores customer info (OrderID → CustomerName).
-- - OrderDetails_2NF table stores product + quantity.
-- - No partial dependencies → Table is now in 2NF.

-- ============================================
-- END OF ASSIGNMENT
-- ============================================







