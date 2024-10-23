# syntax=docker/dockerfile:1
# check=error=true

FROM rockylinux:9.3
LABEL maintainer="saptarshikar"
LABEL version="1.0"

RUN <<EOF
dnf check-update -y
dnf update -y
dnf install -y bash-completion bind-utils iperf3 iproute iproute-tc iputils \
jq mtr nano nmap net-tools OpenIPMI openssh openssh-server openssh-clients \
socat tcpdump tmux traceroute wireshark-cli 
echo 'PS1="\[\033[32m\]\h\[\033[m\]:\[\033[33;1m\]\w\[\033[m\] # "' >> /root/.bashrc
chsh -s /bin/bash root
mkdir /run/sshd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo 'root:Passdrow!!' | chpasswd -c SHA256
EOF

RUN ssh-keygen -A -v
SHELL ["/bin/bash", "-c"]
EXPOSE 10000-20000
EXPOSE 22
EXPOSE 2222
RUN ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519

CMD echo && echo Launching sshd - default port 22, root password is Passdrow!! && \
    /usr/sbin/sshd -D && \
    echo Container ready. IP for eth0 is $(ip addr show eth0 | awk '/inet/{print $2; exit}') && \
    echo launch the container in the background with: docker run --name nettools -p 127.0.0.1:2222:22 -itd scarab82/netwk-tools && \
    echo Then connect via \'ssh root@127.0.0.1 -p 2222\', or use docker exec -it nettools bash && \
    echo && bash


