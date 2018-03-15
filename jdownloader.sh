#!/bin/bash

#
# Display settings on standard out.
#

echo "JDownloader settings"
echo "===================="
echo
echo " USER:	${USER}"
echo " GROUP:	${GROUP}"
echo " UID:	${UID}"
echo " GID:	${GID}"
echo

#
# Change UID / GID of JDownloader user.
#

printf "Updating UID / GID... "
[[ $(id -u ${USER}) == ${UID} ]] || usermod -u ${UID} ${USER}
[[ $(id -g ${GROUP}) == ${GID} ]] || groupmod -g ${GID} ${GROUP}
echo "[DONE]"

#
# Set directory permissions.
#

printf "Setting permissions... "
chown -R ${USER}:${GROUP} $(pwd)
chown ${USER}:${GROUP} /media
echo "[DONE]"

#
# Finally, start JDownloader.
#

echo "Starting JDownloader..."
java -Djava.awt.headless=true -jar JDownloader.jar > $(pwd)/logs/startup.log -norestart 2>&1 &
