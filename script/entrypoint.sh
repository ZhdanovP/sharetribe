#!/bin/bash
# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback


USER_ID=${LOCAL_USER_ID:-9001}

sudo useradd --shell /bin/bash -u $USER_ID -o -c "" app
echo "app ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

chown app /home/app
chgrp app /home/app

export HOME=/home/app

echo "export LANG=en_US.UTF-8" >> ~/.zshrc

[ -e /opt/startup/ ] && for script in /opt/startup/*; do bash $script ; done

printf "Starting with user app, UID : $USER_ID \n\n"
echo   "    You may run sudo without password"
printf "    You may run GIU applications in container\n\n"
#/usr/games/cowsay -f koala "Welcome to $IMAGE_NAME!"
sudo -E -u app "$@"