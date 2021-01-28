
TAGS=$1
if [[ -z ${TAGS} ]]; then
    echo 'please input run "sh run_other.sh [tags] "'
    echo 'tags: vpn_route'
    exit;
fi

workdir=$(cd $(dirname $0); pwd)
cd ${workdir}
ansible-playbook -t ${TAGS} -i inventory/cluster/hosts.yml other.yml

