# !/bin/bash

yum update -y -q && yum upgrade -y -q

yum install epel-release -y -q
yum install \
	-y -q java-1.8.0-openjdk-devel.x86_64 \
	-y -q java-11-openjdk-devel.x86_64 \
	-y -q htop

PROFILE='/etc/profile'
echo "export LANG='ko_KR.UTF-8'" >> ${PROFILE}
echo 'export TZ="Asia/Seoul"' >> ${PROFILE}
echo "alias l='ls -Fah --color=auto'" >> ${PROFILE}
echo "alias ll='ls -Fhal --color=auto'" >> ${PROFILE}
echo 'cl() { clear; ls -Fhal --color=auto ;}' >> ${PROFILE}
echo 'cdl() { clear; cd "$@" && ls -Fhal --color=auto; }'  >> ${PROFILE}
# alias cdl 'clear; cd \!*; ls -Fhal --color=auto'
echo "alias kc='kubectl'" >> ${PROFILE}
echo "alias kcd='kubectl describe'" >> ${PROFILE}
echo "alias kcl='kubectl logs -f'" >> ${PROFILE}
echo "alias dk='docker'" >> ${PROFILE}
source $PROFILE

BASHRC='/etc/bashrc'
echo 'export PS1="\[\e[1;34m\]DEV\[\e[m\]\[\e[1;34m\]-\[\e[m\][\h:\$(pwd)] " ' >> ${BASHRC}
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

# Add timestamp to .bash_history
HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S] "
export HISTTIMEFORMAT
