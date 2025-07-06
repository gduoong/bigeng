module.exports = {
  apps: [{
    name: 'tutoring_platform',  // 项目名称
    script: 'dist/server/index.js',  // 使用编译后的JavaScript文件
    interpreter: 'node',
    interpreter_args: '-r ts-node/register',
    instances: 2,  // 启动2个实例
    exec_mode: 'cluster',  // 使用集群模式
    watch: false,  // 不监视文件变化
    max_memory_restart: '1G',  // 超过1G内存自动重启
    env: {
      NODE_ENV: 'production'
    }
  }]
}