FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y openssh-client x11-apps

# Set timezone to Asia/Tehran
RUN ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime && \
    echo "Asia/Tehran" > /etc/timezone \

CMD ["/bin/bash"]