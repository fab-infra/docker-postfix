# Postfix server based on openSUSE Leap 15.2
FROM fcrespel/base-image:opensuse15.2

# MariaDB
RUN zypper in -y postfix &&\
	zypper clean -a

# Files
COPY ./root /
RUN chmod +x /run.sh

# Ports
EXPOSE 25 587
