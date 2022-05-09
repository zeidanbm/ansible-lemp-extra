#!/bin/bash
LOGFILE="/var/log/clamav/clamav-$(date +'%Y-%m-%d').log";
EMAIL_MSG="Please see the log file attached";
EMAIL_TO=$(echo ADMIN_EMAIL);
DIRTOSCAN="/var/www/wordpress-site";

# start clamav

for S in ${DIRTOSCAN}; do
 DIRSIZE=$(du -sh "$S" 2>/dev/null | cut -f1);
 echo "Starting scan of "$S" directory.
 Directory size: "$DIRSIZE".";
 find "$S" -mtime -1 -type f -print0 | xargs -0 clamscan -rio --remove=yes --detect-pua=yes --move=/home>
 #find /var/log/clamav/ -type f -mtime +30 -exec rm {} \;
 MALWARE=$(tail "$LOGFILE"|grep Infected|cut -d" " -f3);

  if [ "$MALWARE" -ne "0" ];then
     echo "$EMAIL_MSG"|mail -a "$LOGFILE" -s "Malware Found" "$EMAIL_TO";
  fi

done

exit 0


# stop clamav