-- =============================================
-- DATABASE: CHILL NEST INTERIOR (MSSQL Version)
-- AUTHOR: ANTIGRAVITY (Converted for MSSQL compatibility)
-- DATE: 2026-04-19
-- =============================================

-- Xóa database cũ nếu tồn tại
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'chill_nest')
BEGIN
    DROP DATABASE chill_nest;
END
GO

CREATE DATABASE chill_nest;
GO

USE chill_nest;
GO

-- 1. ROLES TABLE
CREATE TABLE roles (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO roles (name) VALUES 
('ROLE_ADMIN'),
('ROLE_CUSTOMER'),
('ROLE_PARTNER');

-- 2. USERS TABLE
CREATE TABLE users (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    username NVARCHAR(50) UNIQUE NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL,
    full_name NVARCHAR(100),
    phone NVARCHAR(20),
    -- Thay thế ENUM bằng CHECK constraint
    status NVARCHAR(20) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'INACTIVE', 'BANNED')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- 3. USER_ROLES TABLE
CREATE TABLE user_roles (
    user_id BIGINT,
    role_id INT,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- 4. PARTNERS TABLE
CREATE TABLE partners (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    user_id BIGINT UNIQUE,
    company_name NVARCHAR(150),
    business_type NVARCHAR(100),
    address NVARCHAR(MAX),
    verified BIT DEFAULT 0, -- MSSQL dùng BIT thay cho BOOLEAN
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 5. SAMPLE DATA
-- Admin
INSERT INTO users (username, email, password, full_name)
VALUES ('admin', 'admin@chillnest.com', '123456', 'Chill Nest Admin');
INSERT INTO user_roles (user_id, role_id) VALUES (1, 1);

-- Customer
INSERT INTO users (username, email, password, full_name)
VALUES ('customer1', 'customer@gmail.com', '123456', N'Nguyễn Văn Khách');
INSERT INTO user_roles (user_id, role_id) VALUES (2, 2);

-- Partner
INSERT INTO users (username, email, password, full_name)
VALUES ('partner1', 'partner@decor.com', '123456', N'Trần Thị Đối Tác');
INSERT INTO user_roles (user_id, role_id) VALUES (3, 3);

INSERT INTO partners (user_id, company_name, business_type, address)
VALUES (3, 'Modern Decor LLC', 'Furniture Supply', N'Hà Nội, Việt Nam');
