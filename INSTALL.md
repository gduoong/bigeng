# 筑克数云 - 在线学习辅导平台

## 环境要求

- Node.js 16.0.0 或更高版本
- npm 7.0.0 或更高版本

## 安装步骤

1. 安装 Node.js

访问 [Node.js 官网](https://nodejs.org/) 下载并安装适合您系统的 Node.js 版本。

2. 克隆项目

```bash
git clone <项目地址>
cd <项目目录>
```

3. 安装依赖

```bash
npm install
```

4. 启动开发服务器

```bash
npm run dev
```

5. 构建生产版本

```bash
npm run build
```

## 目录结构

```
src/
  ├── assets/        # 静态资源
  ├── components/    # 公共组件
  ├── layouts/       # 布局组件
  ├── router/        # 路由配置
  ├── stores/        # 状态管理
  ├── styles/        # 全局样式
  ├── types/         # TypeScript 类型定义
  ├── utils/         # 工具函数
  ├── views/         # 页面组件
  ├── App.vue        # 根组件
  └── main.ts        # 入口文件
```

## 技术栈

- Vue 3
- TypeScript
- Element Plus
- Vue Router
- Pinia
- Vite
- SCSS

## 开发指南

1. 组件开发
- 使用 Composition API
- 遵循 TypeScript 类型定义
- 保持组件单一职责

2. 样式开发
- 使用 SCSS 预处理器
- 遵循 BEM 命名规范
- 优先使用变量和混入

3. 路由开发
- 按模块组织路由
- 使用路由守卫控制访问权限
- 实现路由懒加载

4. 状态管理
- 使用 Pinia 进行状态管理
- 按功能模块拆分 store
- 保持 store 的简洁性

## 常见问题

1. 安装依赖失败
- 检查 Node.js 版本是否符合要求
- 尝试清除 npm 缓存：`npm cache clean --force`
- 删除 node_modules 目录后重新安装

2. 开发服务器启动失败
- 检查端口是否被占用
- 检查环境变量配置
- 查看错误日志进行排查

## 联系方式

如有问题，请联系技术支持团队。 