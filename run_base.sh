
workdir=$(cd $(dirname $0); pwd)
cd ${workdir}

ansible-playbook  -i inventory/cluster/hosts.yml app.yml
