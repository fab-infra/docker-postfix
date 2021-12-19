# Postfix server based on openSUSE Leap 15.3
FROM ghcr.io/fab-infra/base-image:opensuse15.3

# MariaDB
RUN zypper in -y postfix &&\
	zypper clean -a

# Files
COPY ./root /
RUN chmod +x /run.sh

# Ports
EXPOSE 25 587
