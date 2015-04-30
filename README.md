# aws-shadowsocks-install
在aws上安装shadowsocks的脚本

### 使用说明

1. 在 aws 上新开一个 Ubuntu Server 14.04 LTS 的实例
2. 配置安全组的时候打开 TCP - 8388 端口
3. 待实例启动后用 ssh 登录，在终端运行安装脚本: 
```bash
sh <(curl http://goo.gl/ju90J3 -L)
```

Good Luck!
