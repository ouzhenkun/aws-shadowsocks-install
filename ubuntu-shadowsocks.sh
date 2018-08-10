#!/bin/bash

# 安装依赖和shadowsocks
sudo apt-get update
sudo apt-get -y install python-gevent
sudo apt-get -y install python-m2crypto
sudo apt-get -y install python-pip
sudo pip install shadowsocks

# 设置密码
read -p "请设置shadowsocks的密码(默认: 123): " password
if [ "$password" = "" ]; then
    password="123"
fi

# 配置文件 /etc/shadowsocks.json
CONFIG=/etc/shadowsocks.json
sudo dd of=$CONFIG << EOF
{
"server":"0.0.0.0",
"port_password": {
"8331": "${password}",
"8332": "${password}",
"8333": "${password}",
"8334": "${password}",
"8335": "${password}",
"8336": "${password}",
"8337": "${password}",
"8338": "${password}",
"8339": "${password}",},
"local_address": "127.0.0.1",
"local_port":1080,
"timeout":300,
"method":"aes-256-cfb",
"fast_open": true
}
EOF

# 开机启动shadowsocks
sudo dd of=/etc/rc.local << EOF
#!/bin/bash

/usr/local/bin/ssserver -c ${CONFIG}
exit 0
EOF


# 运行
nohup ssserver -c $CONFIG > shadowsocks.log &

# 提示信息
echo "shadowsocks安装好了\n公有IP  : $(curl ifconfig.me)\n配置文件: $CONFIG \n$(cat $CONFIG)"
