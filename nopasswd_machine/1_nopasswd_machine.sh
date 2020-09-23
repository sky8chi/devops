ansible-playbook -i ../hosts 1_nopasswd_machine.yml

#for ip in `cat ../hosts`
#do 
#  tmp_ip=`echo $ip | grep -Eoe "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])"`;
#  if [[ "$tmp_ip" != "" ]]; then 
#    echo "=======start ip: " $ip
#    ssh-copy-id -i ~/.ssh/id_dsa.pub root@$ip 
#  else 
#    echo  "========skip not ip: "$ip
#  fi 
#done

