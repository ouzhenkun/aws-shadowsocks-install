#!/bin/bash

# 安装依赖和shadowsocks
sudo apt-get update
sudo apt-get -y install python-gevent
sudo apt-get -y install python-m2crypto
sudo apt-get -y install python-pip
sudo pip install shadowsocks

# 设置密码，端口，端口个数
read -p "请设置shadowsocks的密码(默认: 123):  " password 
read -p "请设置shadowsocks的起始端口(默认: 8000): " port 
read -p "请设置shadowsocks的端口个数(默认: 10): " count 

if [ "$password" == "" ]; then 
	password="123"
fi 
if [ "$port" == "" ]; then 
	port="8000"
fi 
if [ "$count" == "" ]; then 
	count="10"
fi 

str_port_info="{"

while [ $count -ge 1 ]
do
	str_item=""
	if [ 1 -eq $count ]
	then 
		str_item+="\"${port}\":"
		str_item+="\"${password}\""
	else 
		str_item+="\"${port}\":"
		str_item+="\"${password}\""
		str_item+=","
	fi 
	str_port_info=$str_port_info$str_item
	
	((port++))
	((count--))
done

str_port_info=$str_port_info"}"

echo $str_port_info

# 配置文件 /etc/shadowsocks.json
CONFIG=/etc/shadowsocks.json
sudo dd of=$CONFIG << EOF
{
"server":"0.0.0.0",
"port_password": $str_port_info,
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
printf "shadowsocks安装好了"公有IP  : $(curl ifconfig.me)\n配置文件: $CONFIG \n$(cat $CONFIG)"
