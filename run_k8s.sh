
TAGS=$1
if [[ -z ${TAGS} ]]; then
    echo 'please input run "sh run_k8s.sh [tags] "'
    echo 'tags: nfs'
    exit;
fi
workdir=$(cd $(dirname $0); pwd)
cd ${workdir}

ansible-playbook -t ${TAGS} -i inventory/cluster/hosts.yml k8s.yml

