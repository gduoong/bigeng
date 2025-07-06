-- 创建数据库
CREATE DATABASE IF NOT EXISTS tutoring_platform DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE tutoring_platform;

-- 用户表
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('student', 'mentor') NOT NULL,
  nickname VARCHAR(50),
  avatar VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_email (email),
  INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 导师认证表
CREATE TABLE mentor_certifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  mentor_id INT NOT NULL,
  university VARCHAR(100),
  major VARCHAR(100),
  degree VARCHAR(50),
  id_card_file VARCHAR(255),
  diploma_file VARCHAR(255),
  status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
  submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  reviewed_at DATETIME,
  FOREIGN KEY (mentor_id) REFERENCES users(id),
  INDEX idx_status (status),
  INDEX idx_mentor (mentor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 委托任务表
CREATE TABLE commissions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  title VARCHAR(100),
  type ENUM('课业辅导', '论文辅导', '留学文书'),
  subject_path VARCHAR(255),
  description TEXT,
  attachment VARCHAR(255),
  budget DECIMAL(10,2),
  status ENUM('pending', 'approved', 'rejected', 'matched', 'finished') DEFAULT 'pending',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES users(id),
  INDEX idx_status (status),
  INDEX idx_type (type),
  INDEX idx_student (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 聊天记录表
CREATE TABLE chat_messages (
  id INT AUTO_INCREMENT PRIMARY KEY,
  sender_id INT,
  receiver_id INT,
  content TEXT,
  message_type ENUM('text', 'image', 'file') DEFAULT 'text',
  is_read BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES users(id),
  FOREIGN KEY (receiver_id) REFERENCES users(id),
  INDEX idx_sender (sender_id),
  INDEX idx_receiver (receiver_id),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 提现记录表
CREATE TABLE withdrawals (
  id INT AUTO_INCREMENT PRIMARY KEY,
  mentor_id INT NOT NULL,
  amount DECIMAL(10,2),
  status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
  requested_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  processed_at DATETIME,
  FOREIGN KEY (mentor_id) REFERENCES users(id),
  INDEX idx_status (status),
  INDEX idx_mentor (mentor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 管理员表
CREATE TABLE admins (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 系统通知表
CREATE TABLE notifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  type ENUM('系统', '审核', '提现', '提示') DEFAULT '系统',
  title VARCHAR(100),
  content TEXT,
  is_read BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  INDEX idx_user (user_id),
  INDEX idx_type (type),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 创建默认管理员账号
INSERT INTO admins (username, password) VALUES ('admin', '$2a$10$X7EBGITGHwzLEY1MEPcUeODk/9ZYyU8hR.RUCiFD8D6YlGz0H3k6a');
-- 默认密码为 admin123，已使用 bcrypt 加密 