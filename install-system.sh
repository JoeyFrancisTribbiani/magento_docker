# 修复es的报错
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
sysctl -p

docker-compose up -d
