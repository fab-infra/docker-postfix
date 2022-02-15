[![build](https://github.com/fab-infra/docker-postfix/actions/workflows/build.yml/badge.svg)](https://github.com/fab-infra/docker-postfix/actions/workflows/build.yml)

# Postfix Docker image

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 25 | SMTP port |
| 587 | Submission port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| FROM_HEADER | From header value | $(hostname -f) |
| POSTFIX_ADD_MYNETWORKS_STYLE | Trusted clients list style (host/subnet/class) | subnet |
| POSTFIX_BASIC_SPAM_PREVENTION | Spam prevention level (off/medium/hard) | medium |
| POSTFIX_MYHOSTNAME | Server hostname to expose | $(hostname -f) |
| POSTFIX_MYNETWORKS | Trusted clients list subnets (comma-separated) | |
| POSTFIX_RBL_HOSTS | Realtime Blackhole Lists hosts (comma-separated) | sbl.spamhaus.org, xbl.spamhaus.org, spam.sorbs.net |
| POSTFIX_RELAYHOST | Relay host name for external recipients | |
| POSTFIX_SMTP_TLS_CLIENT | Enable TLS client | yes |
| POSTFIX_SMTP_TLS_SERVER | Enable TLS server | no |
| POSTFIX_TLS_CERTFILE | PEM-encoded certificate file for TLS server | |
| POSTFIX_TLS_KEYFILE | PEM-encoded private key file for TLS server | |
| SMTPD_LISTEN_REMOTE | Listen to remote connections | yes |
| SMTPD_MILTERS | Milters list (comma-separated) | |

## Volumes

The following container paths can be used to mount a dedicated volume or to customize configuration.

| Path | Description |
| ---- | ----------- |
| /var/spool/postfix | Data directory |

## Useful links

- [Postfix documentation](https://www.postfix.org/documentation.html)
