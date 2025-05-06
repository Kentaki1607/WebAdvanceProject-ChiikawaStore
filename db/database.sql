
-- DROP TABLE nếu tồn tại (dành cho test import nhiều lần)
DROP TABLE IF EXISTS order_details, orders, products, categories, users;

-- Bảng người dùng
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Bảng phân loại sản phẩm
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Bảng sản phẩm
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(255),
    category_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Bảng đơn hàng
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    address TEXT,
    payment_method ENUM('online', 'cash') DEFAULT 'cash',
    status ENUM('pending', 'confirmed', 'delivered', 'cancelled') DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Bảng chi tiết đơn hàng
CREATE TABLE order_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Dữ liệu mẫu: users
INSERT INTO users (username, password, email, role) VALUES
('admin', 'admin123', 'admin@store.com', 'admin'),
('hoang', '123456', 'hoang@student.com', 'user');

-- Dữ liệu mẫu: categories
INSERT INTO categories (name) VALUES
('Keychains'), ('T-Shirts'), ('Plushies');

-- Dữ liệu mẫu: products
INSERT INTO products (name, description, price, image_url, category_id) VALUES
('Chiikawa Keychain A', 'Cute metal keychain', 4.99, 'uploads/products/keychain1.jpg', 1),
('Chiikawa T-Shirt S', 'Small size shirt with Chiikawa print', 9.99, 'uploads/products/shirt1.jpg', 2),
('Chiikawa Plushie L', 'Large soft plush toy', 19.99, 'uploads/products/plushie1.jpg', 3);
