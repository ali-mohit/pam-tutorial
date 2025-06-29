FROM ubuntu:22.04

# Set timezone to Asia/Tehran
RUN ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime && \
    echo "Asia/Tehran" > /etc/timezone

RUN apt-get update && \
    apt-get install -y openssh-server xauth x11-apps && \
    useradd -m testuser && \
    echo 'testuser:testpassword' | chpasswd && \
    mkdir /var/run/sshd


# Allow password authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
