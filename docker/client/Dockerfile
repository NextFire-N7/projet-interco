FROM base-ubuntu
# Linphone est un logiciel de VoIP qui fonctionne comme Skype
RUN apt install -y --no-install-recommends linphone
ENTRYPOINT /data/init.sh; exec sleep infinity
