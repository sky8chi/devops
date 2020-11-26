
hostType=$1
host=$2

if [[ -z ${hostType} || -z ${host} ]]; then
    echo 'please input run "sh run_showhostinfo.sh [host:group] [hostname] "'
    exit;
fi

workdir=$(cd $(dirname $0); pwd)
cd ${workdir}

ansible-playbook -t ${hostType} -i inventory/cluster/hosts.yml showHostInfo.yml -e "showInfoHost=${host}"
