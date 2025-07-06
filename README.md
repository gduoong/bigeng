# 筑克数云在线辅导平台

## 项目结构说明

```
├── src/                      # 源代码目录
│   ├── assets/              # 静态资源文件
│   │   ├── images/         # 图片资源
│   │   └── styles/         # 全局样式
│   ├── components/         # 公共组件
│   ├── views/              # 页面组件
│   │   ├── home/          # 首页相关
│   │   ├── student/       # 学生端页面
│   │   ├── tutor/         # 导师端页面
│   │   └── admin/         # 管理员端页面
│   ├── router/             # 路由配置
│   ├── stores/             # Pinia 状态管理
│   ├── utils/              # 工具函数
│   └── server/             # 后端服务
│       ├── config/        # 配置文件
│       ├── controllers/   # 控制器
│       ├── models/        # 数据模型
│       ├── routes/        # 路由定义
│       ├── services/      # 业务服务
│       └── docs/          # API文档
├── public/                 # 静态公共资源
└── dist/                   # 构建输出目录
```

## 服务器环境要求

- Ubuntu 22.04 LTS x86_64
- CPU: 4核
- 内存: 8G
- 宝塔面板

## 宝塔面板配置步骤

1. 安装必要的软件：
   ```bash
   # 在宝塔面板中安装以下软件
   - Nginx 1.20+
   - MySQL 8.0+
   - Node.js 18.0+
   - PM2 管理器
   - Redis
   ```

2. MySQL配置：
   - 创建数据库：tutoring_platform
   - 设置字符集：utf8mb4
   - 创建用户并授权
   - 导入数据库文件：database.sql

3. Nginx配置：
   ```nginx
   server {
       listen 80;
       server_name your_domain.com;  # 替换为你的域名

       # 前端静态文件
       location / {
           root /www/wwwroot/your_domain/dist;
           index index.html;
           try_files $uri $uri/ /index.html;
       }

       # API 接口
       location /api {
           proxy_pass http://localhost:3000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }

       # WebSocket
       location /ws {
           proxy_pass http://localhost:3000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection "Upgrade";
           proxy_set_header Host $host;
       }
   }
   ```

## 项目部署步骤

1. 安装 Node.js 依赖：
   ```bash
   cd /www/wwwroot/your_domain
   npm install
   ```

2. 创建环境配置文件：
   ```bash
   # 创建 .env 文件
   cat > .env << EOF
   VITE_API_URL=https://your_domain.com
   VITE_WS_URL=wss://your_domain.com
   DB_HOST=localhost
   DB_USER=your_db_user
   DB_PASSWORD=your_db_password
   DB_NAME=tutoring_platform
   JWT_SECRET=your_secret_key
   EOF
   ```

3. 构建前端：
   ```bash
   npm run build
   ```

4. 配置 PM2：
   ```bash
   # 创建 PM2 配置文件
   cat > ecosystem.config.js << EOF
   module.exports = {
     apps: [{
       name: 'tutoring-platform',
       script: 'src/server/index.ts',
       interpreter: 'node',
       interpreter_args: '-r ts-node/register',
       instances: 2,
       exec_mode: 'cluster',
       watch: false,
       max_memory_restart: '1G',
       env: {
         NODE_ENV: 'production'
       }
     }]
   }
   EOF

   # 启动服务
   pm2 start ecosystem.config.js
   ```

5. 设置开机自启：
   ```bash
   pm2 startup
   pm2 save
   ```

## 文件说明

### 前端文件
- `src/views/`: 页面组件
  - `Home.vue`: 首页组件
  - `student/Profile.vue`: 学生个人中心
  - `tutor/Login.vue`: 导师登录页
  - `admin/Dashboard.vue`: 管理员仪表盘

- `src/stores/`: 状态管理
  - `user.ts`: 用户状态管理
  - `commission.ts`: 委托任务状态管理
  - `chat.ts`: 聊天和通知状态管理

- `src/utils/`: 工具函数
  - `request.ts`: Axios 请求封装
  - `websocket.ts`: WebSocket 客户端

### 后端文件
- `src/server/config/`: 配置文件
  - `database.ts`: 数据库配置
  - `constants.ts`: 常量定义

- `src/server/controllers/`: 控制器
  - `student.controller.ts`: 学生相关接口
  - `tutor.controller.ts`: 导师相关接口
  - `admin.controller.ts`: 管理员相关接口
  - `chat.controller.ts`: 聊天相关接口

- `src/server/models/`: 数据模型
  - `user.model.ts`: 用户模型
  - `commission.model.ts`: 委托任务模型
  - `chat.model.ts`: 聊天消息模型

- `src/server/services/`: 业务服务
  - `websocket.ts`: WebSocket 服务

### 数据库文件
- `database.sql`: 数据库建表语句

## 性能优化建议

1. 数据库优化：
   - 为常用查询字段创建索引
   - 配置 MySQL 缓存
   - 定期优化表结构

2. Nginx优化：
   ```nginx
   # 开启 gzip 压缩
   gzip on;
   gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
   
   # 配置缓存
   location /static/ {
       expires 7d;
       add_header Cache-Control "public, no-transform";
   }
   ```

3. Node.js优化：
   - 使用 PM2 的 cluster 模式
   - 配置合适的内存限制
   - 启用请求限流

## 监控和维护

1. 日志管理：
   - 使用 PM2 日志轮转
   - 配置 Nginx 访问日志
   - 设置数据库慢查询日志

2. 性能监控：
   - 使用 PM2 监控面板
   - 配置服务器监控
   - 设置异常告警

3. 备份策略：
   - 每日数据库备份
   - 定期代码备份
   - 配置文件备份

## 安全建议

1. 服务器安全：
   - 更新系统补丁
   - 配置防火墙
   - 限制端口访问

2. 应用安全：
   - 启用 HTTPS
   - 配置 CSP 策略
   - 实施 Rate Limiting

3. 数据安全：
   - 定期备份数据
   - 加密敏感信息
   - 日志安全存储

## 常见问题处理

1. 服务无法启动：
   - 检查端口占用
   - 查看错误日志
   - 验证配置文件

2. 数据库连接失败：
   - 检查连接字符串
   - 验证用户权限
   - 查看错误日志

3. WebSocket 连接问题：
   - 检查 Nginx 配置
   - 验证防火墙设置
   - 查看连接日志 