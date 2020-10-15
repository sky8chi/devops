# 下载
* https://downloads.mysql.com/archives/community/
* 5.7.30
* 把mysql的bin文件下载下来放在common role的file目录下重命名为mysql.zip (路径: roles/common/files/mysql.zip)
1. 编辑 hosts文件，将mysql_M，mysql_S IP地址填入，mysql_S 可以是多个
2. 编辑 vars.yaml文件
3. 运行playbook 
sh run.sh
4. 验证mysql 的主从
sh run_test.sh
