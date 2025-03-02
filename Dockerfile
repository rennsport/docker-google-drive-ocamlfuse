FROM ubuntu:bionic

ENV DRIVE_PATH="/mnt/gdrive"

# Install prerequisites and google-drive-ocamlfuse in a single layer to reduce image size
RUN apt-get update && \
    apt-get install -y software-properties-common apt-transport-https ca-certificates gnupg --no-install-recommends && \
    add-apt-repository ppa:alessandro-strada/ppa && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F639B041 && \
    apt-get update && \
    apt-get install -y google-drive-ocamlfuse fuse && \
    echo "user_allow_other" >> /etc/fuse.conf && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/log/alternatives.log /var/log/bootstrap.log /var/log/dpkg.log

# Copy entrypoint script and make it executable
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

CMD ["docker-entrypoint.sh"]
