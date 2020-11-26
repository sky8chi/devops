# devops
以下所有task功能，都是基于根目录下的hosts文件
## 基础功能
* ~~[nopasswd_machine (打通机器)](nopasswd_machine)~~

* ~~[ssh_speed_up (ssh连接加速)](ssh_speed_up)~~

* ~~[change_require_tty (关闭sudo远程需要tty执行命令)](change_require_tty)~~

* ~~[yum_install (yum安装常用的软件)](yum_install)~~

* ~~[stop_firewalld (关闭防火墙)](stop_firewalld)~~

* ~~[change_swap (开关swap)](change_swap)~~

* ~~[close_selinux(关闭安全)](close_selinux)~~

* base(基础集成安装)

  ```shell
  sh run_base.sh
  ```

  

## 应用

* mysql

  ```shell
  # 下载
  # https://downloads.mysql.com/archives/community/
  # 5.7.30
  # 把mysql的bin文件下载下来放在common role的files目录下重命名为mysql.zip (路径: roles/app/mysql/common/files/mysql.zip)
  1. 编辑 hosts文件，将mysql_M，mysql_S IP地址填入，mysql_S 可以是多个。mysql_S需要指定mastere变量 master_host_ip
  2. 编辑 vars/mysql.yaml文件 设置mysql
  3. 运行playbook
  sh run_app.sh mysql
  ```

* nfs

  ```shell
  # 配置 hosts 
  # 服务端: nfs_svr  客户端：nfs_cli
  # 服务端存储路径：roles/app/nfs/nfs-server/vars/main.yml
  sh run_app.sh nfs
  ```

* redis

  ```
  redis:
        hosts:
          L3:
            redisPorts: ["6379", "6378"]  # 开启的redis端口
          L4:
            redisPorts: ["6379", "6378"]
          L5:
            redisPorts: ["6379", "6378"]
        vars:
          redisVersion: redis-6.0.6				# redis版本
          redisInstallDir: /home/data     # redis安装目录
          redisReplica:                   # redis集群主从关系
            - {"L3": "6379", "L4": "6378"}   
            - {"L4": "6379", "L5": "6378"}
            - {"L5": "6379", "L3": "6378"}
            
            
  sh run_app.sh redis  # 安装redis
  sh run_app.sh redis-replica  # 上面redis的部分命令，建立集群关系
  ```


* rabbitmq单机 

  ```yaml
  # hosts
  rabbitmq:
        hosts:
          L1:
  
  #app.yml        
  rabbitmqVersion: 3.8.9
  erlangVersion: 23.1
  centosVersion: 7.8
  
  sh run_app.sh rabbitmq
  ```

  

## k8s

> https://api.playbook.cloud/v1/modules/k8s.html

