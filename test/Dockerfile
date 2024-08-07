FROM ruby:3.3

RUN apt-get update && apt-get install -y systemd systemd-sysv openssh-server sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd --system --gid 1000 willnet && \
    useradd willnet --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R willnet:willnet /var
RUN echo "willnet ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/willnet
RUN echo 'willnet:password' | chpasswd

EXPOSE 22
CMD ["/lib/systemd/systemd"]
