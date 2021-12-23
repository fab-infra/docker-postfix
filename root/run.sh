#!/bin/bash

# Set default environment
SMTPD_LISTEN_REMOTE="${SMTPD_LISTEN_REMOTE:-yes}"
SMTPD_MILTERS="${SMTPD_MILTERS:-}"
POSTFIX_RBL_HOSTS="${POSTFIX_RBL_HOSTS:-sbl.spamhaus.org, xbl.spamhaus.org, spam.sorbs.net}"
POSTFIX_BASIC_SPAM_PREVENTION="${POSTFIX_BASIC_SPAM_PREVENTION:-medium}"
POSTFIX_SMTP_TLS_CLIENT="${POSTFIX_SMTP_TLS_CLIENT:-yes}"
POSTFIX_TLS_CERTFILE="${POSTFIX_TLS_CERTFILE:-}"
POSTFIX_TLS_KEYFILE="${POSTFIX_TLS_KEYFILE:-}"
POSTFIX_MYNETWORKS="${POSTFIX_MYNETWORKS:-}"

# Update sysconfig from environment variables
for FILE in /etc/sysconfig/mail /etc/sysconfig/postfix; do
    grep '^[^#].*=' "$FILE" | while IFS='=' read KEY VALUE; do
        if [ -n "${!KEY+x}" ]; then
            echo "Updating $FILE: $KEY=${!KEY}"
            sed -i "s#^$KEY=.*\$#$KEY=\"${!KEY}\"#g" "$FILE"
        fi
    done
done

# Update postfix config
/etc/postfix/system/config_postfix
/etc/postfix/system/update_postmaps
sed -i 's/^#submission/submission/g' /etc/postfix/master.cf
postconf -e maillog_file="/dev/stdout"
postconf -e smtpd_milters="$SMTPD_MILTERS"
postconf -e non_smtpd_milters="\$smtpd_milters"
postconf -e milter_default_action="accept"
postconf -e internal_mail_filter_classes="bounce"
if [ -n "$POSTFIX_MYNETWORKS" ]; then
    postconf -e mynetworks="$POSTFIX_MYNETWORKS"
fi

# Start in foreground
exec /usr/sbin/postfix start-fg
