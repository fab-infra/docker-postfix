# Postfix server based on openSUSE Leap 15.4
FROM ghcr.io/fab-infra/base-image:opensuse15.4

# MariaDB
RUN zypper in -y postfix &&\
	zypper clean -a

# Files
COPY ./root /

# Ports
EXPOSE 25 587
