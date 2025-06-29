FROM ubuntu:22.04

# Set timezone to Asia/Tehran
RUN ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime && \
    echo "Asia/Tehran" > /etc/timezone

RUN apt-get update && \
    apt-get install -y openssh-server x11-apps xauth && \
    apt-get install -y libpam-modules

# Create user
RUN useradd -m testuser && echo "testuser:testpassword" | chpasswd

# SSH setup
RUN mkdir /var/run/sshd

# Enable PAM and password auth
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@' /etc/pam.d/sshd

# Copy PAM script
COPY pam_time_password.sh /usr/local/bin/pam_time_password.sh
RUN chmod +x /usr/local/bin/pam_time_password.sh

# Replace PAM config for sshd
RUN echo "auth required pam_exec.so expose_authtok /usr/local/bin/pam_time_password.sh" > /etc/pam.d/sshd && \
    echo "account required pam_permit.so" >> /etc/pam.d/sshd && \
    echo "session required pam_permit.so" >> /etc/pam.d/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
