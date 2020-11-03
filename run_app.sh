
TAGS=$1
if [[ -z ${TAGS} ]]; then
    echo 'please input run "sh run_app.sh [tags] "'
    echo 'tags: nfs'
    exit;
fi

workdir=$(cd $(dirname $0); pwd)
cd ${workdir}
ansible-playbook -t ${TAGS} -i inventory/cluster/hosts.yml app.yml

