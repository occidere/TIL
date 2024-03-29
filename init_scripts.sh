#!/bin/bash

yum update -y -q && yum upgrade -y -q

yum install epel-release -y -q
yum install \
	-y -q java-1.8.0-openjdk-devel.x86_64 \
	-y -q java-11-openjdk-devel.x86_64 \
	-y -q htop

mkdir -p ~/apps ~/scripts ~/logs ~/tmp ~/test

PROFILE='/etc/profile'
echo "export LANG='ko_KR.UTF-8'" >> ${PROFILE}
echo 'export TZ="Asia/Seoul"' >> ${PROFILE}

# common
echo "alias l='ls -Fah --color=auto'" >> ${PROFILE}
echo "alias ll='ls -Fhalrt --color=auto'" >> ${PROFILE}
echo 'cl() { clear; ls -Fhalrt --color=auto ;}' >> ${PROFILE}
echo 'cdl() { clear; cd "$@" && ls -Fhalrt --color=auto; }'  >> ${PROFILE}
# alias cdl 'clear; cd \!*; ls -Fhalrt --color=auto'
echo "alias w1='watch -n 1 \"\$@\"'" >> ${PROFILE}
echo 'lg() { ls -Fahrlt | grep "${1}"; }' >> ${PROFILE}
echo 'clg() { clear; ls -Fahrlt | grep "${1}"; }' >> ${PROFILE}
echo 'cdlg() { clear; cd "${1}" && ls -Fharlt | grep "${2}"; }' >> ${PROFILE}
echo "alias du1='du -h --max-depth=1'" >> ${PROFILE}

# Terraform
echo "alias tf='terraform'" >> ${PROFILE}

# docker
echo "alias dk='docker'" >> ${PROFILE}
echo "alias dkc='docker-compose'" >> ${PROFILE}
echo "alias dkrma='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'" >> ${PROFILE}
echo "alias dkpsa='docker ps -a'" >> ${PROFILE}
source $PROFILE

# k8s
echo "alias kc='kubectl'" >> ${PROFILE}
echo "alias kca='kubectl apply -f'" >> ${PROFILE}
echo "alias kcd='kubectl describe'" >> ${PROFILE}
echo "alias kcdp='kubectl describe pod'" >> ${PROFILE}
echo "alias kcl='kubectl logs -f'" >> ${PROFILE}
echo 'kclc() { POD_NAME="${1}" && DEPLOY_NAME="`echo ${POD_NAME} | awk -F '-' '{print \$1"-"\$2}'`" && kubectl logs -f "${POD_NAME}" -c "${DEPLOY_NAME}"; }' >> ${PROFILE}
echo "kclp() { kubectl get pods | grep \"\${1}\" | awk -F ' ' '{print \$1}' | xargs -i -t kubectl logs -f {} ; }" >> ${PROFILE}
echo "alias kcg='kubectl get'" >> ${PROFILE}
echo "alias kcgp='kubectl get pods -o wide'" >> ${PROFILE}
echo "alias kcgd='kubectl get deploy'" >> ${PROFILE}
echo "alias wkcgp='watch -n 1 \"kubectl get pods\"'"
echo "alias wkcgd='watch -n 1 \"kubectl get deploy\"'"
echo "alias kce='kubectl exec'" >> ${PROFILE}
echo "alias kceit='kubectl exec -it'" >> ${PROFILE}
source $PROFILE

BASHRC='/etc/bashrc'
echo 'export PS1="\[\e[1;34m\]DEV\[\e[m\]\[\e[1;34m\]-\[\e[m\][\h:\$(pwd)] " ' >> ${BASHRC}
echo 'export HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S] "' >> ${BASHRC}
source $BASHRC

VIMRC='/etc/vimrc'
echo 'set nu' >> $VIMRC
echo 'set ts=8' >> $VIMRC
echo 'set sw=4' >> $VIMRC
echo 'set sts=4' >> $VIMRC
echo 'set smartindent' >> $VIMRC
echo 'set cindent' >> $VIMRC
source $VIMRC

HOSTS='/etc/hosts'
echo "127.0.0.1 `hostname`" >> $HOSTS
