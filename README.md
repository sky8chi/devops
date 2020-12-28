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

  ```shell
  # redis集群
  # host配置
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
  
  # 单实例
  
  # host配置
  	redis_single:
        hosts:
          L1:
            redisPorts: ["6379"]
        vars:
          redisVersion: redis-6.0.6
          redisInstallDir: /home/data
          
  ansible-playbook -t redis -i inventory/cluster/hosts.yml app.yml -l L1
  
  # 修改config/redis-6379.conf 重启
  cluster-enabled no
  
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

* mongodb

  ```shell
  # hosts
  mongodb:
  	hosts:
  		L2:
  
  sh run_app.sh mongodb
  ```

  

## k8s

> https://api.playbook.cloud/v1/modules/k8s.html

* dashboard

  ```shell
  # 暴露dashboard
  sh run_k8s.sh dashboard
  # 获取token
  sh run_k8s.sh dashboard_token
  ```

* metrics_server

  ```shell
  # 统计机器资源插件 安装成功dashboard会展示  （机器测试kubectl top pod）
  sh run_k8s.sh metrics_server
  ```

  

* 使用pip3实装k8s模块对应的软件

  ```shell
  sh run_k8s.sh pip
  
  # 如果有其他依赖修改 roles/k8s/pip/tasks/pip.yml
  ```

* nfspvc

  ```shell
  # k8s 集群支持动态pvc
  sh run_k8s.sh nfspvc
  
  # 配置见default
  ```

* harbor

  ```shell
  # k8s集群加入harbor   host及证书
  sh run_k8s.sh harbor
  ```

* helm

  ```shell
  # k8s master节点及当前机器安装helm
  sh run_k8s.sh helm
  ```

* elk

  ```shell
  # 通过helm安装elk
  sh run_k8s.sh elk
  
  # 集群配置 通过修改templates 模板
  ```

* springboot_demo

  ```shell
  # springboot测试集群发布
  sh run_k8s.sh springboot_demo
  
  # 项目见 https://github.com/sky8chi/springboot-k8s-test
  # 项目打包镜像到harbor，deployment拉取镜像运行
  ```

* clean_image

  ```shell
  # 清理镜像
  sh run_k8s.sh clean_image
  # 修改k8s.yml 参数控制 或直接执行命令 
  
  ansible-playbook -t clean_image -i inventory/cluster/hosts.yml k8s.yml -e "image_label=app=pay_gateway until_time=2s"
  ```

* pay

  ```shell
  # 源代码  https://github.com/sky8chi/roncoo-pay.git
  
  
  #*** 运营系统
  # 部署
  sh run_k8s.sh pay_boss_deploy
  # 删除deployment （此步骤用于不改镜像版本的情况，更新镜像。需要结合清理镜像）
  sh run_k8s.sh pay_boss_delete_deployment
  ansible-playbook -t clean_image -i inventory/cluster/hosts.yml k8s.yml -e "image_label=app=pay_boss until_time=2s"
  
  #*** 商户系统
  sh run_k8s.sh pay_mch_deploy
  sh run_k8s.sh pay_mch_delete_deployment
  ansible-playbook -t clean_image -i inventory/cluster/hosts.yml k8s.yml -e "image_label=app=pay_mch until_time=2s"
  
  #*** gateway
  sh run_k8s.sh pay_gateway_deploy
  sh run_k8s.sh pay_gateway_delete_deployment
  ansible-playbook -t clean_image -i inventory/cluster/hosts.yml k8s.yml -e "image_label=app=pay_gateway until_time=2s"
  
  #*** sample shop
  sh run_k8s.sh pay_sample-shop_deploy
  sh run_k8s.sh pay_sample-shop_delete_deployment
  ansible-playbook -t clean_image -i inventory/cluster/hosts.yml k8s.yml -e "image_label=app=pay_sample-shop until_time=2s"
  ```

* easymock

  ```shell
  # 修改配置 （redis不支持集群）
  mv templates/configmap.yml.j2.example templates/configmap.yml.j2
  
  sh run_k8s.sh pay_easymock_deploy
  sh run_k8s.sh pay_easymock_delete_deployment
  ```

  

