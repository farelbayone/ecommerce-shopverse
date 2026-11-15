CREATE DATABASE IF NOT EXISTS ecommerce_pro CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ecommerce_pro;

CREATE TABLE users (
 id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(120) NOT NULL,
 email VARCHAR(150) NOT NULL UNIQUE,
 password VARCHAR(255) NOT NULL,
 role ENUM('admin','user') DEFAULT 'user',
 phone VARCHAR(30), address TEXT,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
 id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(100) NOT NULL,
 slug VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE products (
 id INT AUTO_INCREMENT PRIMARY KEY,
 category_id INT NULL,
 name VARCHAR(160) NOT NULL,
 slug VARCHAR(180) NOT NULL UNIQUE,
 description TEXT,
 price DECIMAL(12,2) NOT NULL,
 discount_percent INT DEFAULT 0,
 stock INT DEFAULT 0,
 image VARCHAR(255) DEFAULT 'default.svg',
 featured TINYINT(1) DEFAULT 0,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE SET NULL
);

CREATE TABLE wishlists (
 id INT AUTO_INCREMENT PRIMARY KEY,
 user_id INT NOT NULL, product_id INT NOT NULL,
 UNIQUE KEY uq_wishlist(user_id,product_id),
 FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
 FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE coupons (
 id INT AUTO_INCREMENT PRIMARY KEY,
 code VARCHAR(50) NOT NULL UNIQUE,
 discount_percent INT NOT NULL,
 min_purchase DECIMAL(12,2) DEFAULT 0,
 active TINYINT(1) DEFAULT 1
);

CREATE TABLE orders (
 id INT AUTO_INCREMENT PRIMARY KEY,
 user_id INT NOT NULL,
 total DECIMAL(12,2) NOT NULL,
 discount DECIMAL(12,2) DEFAULT 0,
 grand_total DECIMAL(12,2) NOT NULL,
 payment_method VARCHAR(50) NOT NULL,
 status ENUM('Pending','Diproses','Dikirim','Selesai','Dibatalkan') DEFAULT 'Pending',
 shipping_address TEXT NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE order_items (
 id INT AUTO_INCREMENT PRIMARY KEY,
 order_id INT NOT NULL,
 product_id INT NULL,
 product_name VARCHAR(160) NOT NULL,
 price DECIMAL(12,2) NOT NULL,
 qty INT NOT NULL,
 subtotal DECIMAL(12,2) NOT NULL,
 FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,
 FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE SET NULL
);

CREATE TABLE reviews (
 id INT AUTO_INCREMENT PRIMARY KEY,
 user_id INT NOT NULL, product_id INT NOT NULL,
 rating INT NOT NULL, comment TEXT,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 UNIQUE KEY uq_review(user_id,product_id),
 FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
 FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
);

INSERT INTO categories(name,slug) VALUES
('Elektronik','elektronik'),('Fashion','fashion'),('Aksesoris','aksesoris'),('Rumah','rumah');

INSERT INTO products(category_id,name,slug,description,price,discount_percent,stock,image,featured) VALUES
(1,'Wireless Headphone Pro','wireless-headphone-pro','Headphone wireless premium dengan noise reduction dan baterai tahan lama.',799000,15,24,'headphone.svg',1),
(1,'Smart Watch Active','smart-watch-active','Smartwatch modern untuk aktivitas harian, olahraga, dan notifikasi.',649000,10,18,'watch.svg',1),
(2,'Urban Hoodie','urban-hoodie','Hoodie nyaman dengan bahan lembut dan desain minimalis.',329000,5,40,'hoodie.svg',1),
(2,'Classic Sneakers','classic-sneakers','Sneakers kasual untuk aktivitas sehari-hari.',459000,12,26,'shoes.svg',1),
(3,'Minimal Backpack','minimal-backpack','Backpack ringkas dan stylish untuk kerja maupun kuliah.',289000,0,35,'bag.svg',0),
(4,'Desk Lamp Aura','desk-lamp-aura','Lampu meja LED dengan beberapa tingkat kecerahan.',219000,8,17,'lamp.svg',0),
(3,'Mechanical Keyboard Lite','mechanical-keyboard-lite','Keyboard mekanikal ringkas untuk produktivitas dan gaming.',599000,20,22,'keyboard.svg',1),
(1,'Portable Speaker Mini','portable-speaker-mini','Speaker bluetooth portable dengan suara jernih.',379000,10,32,'speaker.svg',0);

INSERT INTO coupons(code,discount_percent,min_purchase,active) VALUES
('WELCOME10',10,200000,1),('HEMAT15',15,500000,1);

INSERT INTO users(name,email,password,role) VALUES
('Administrator','admin@shopverse.test','$2y$12$wSafMVcdQt1i70cKNgkjMOZVJIsZSjkoP0tMd8NLM4CZgpYdTbYHe','admin');
