FROM gentoo/stage3-amd64-hardened

# installing witchcraft deps
RUN emerge-webrsync -q
RUN emerge dev-perl/Class-Load 
RUN emerge dev-perl/Class-Load-XS 
RUN emerge dev-perl/List-MoreUtils
RUN emerge dev-perl/DateTime
RUN emerge dev-perl/DateTime-Locale  
RUN emerge dev-perl/libwww-perl 
RUN emerge App-cpanminus
# downloading and install witchcraft
RUN wget 'https://codeload.github.com/Spike-Pentesting/App-witchcraft/tar.gz/master' -O witchcraft.tar.gz && tar xvf witchcraft.tar.gz && cd App-witchcraft-master && cpanm --installdeps -n . && cpanm .
RUN perl-cleaner --all
# configuring witchcraft
RUN mkdir -p /root/.witchcraft && cp -rfv /App-witchcraft-master/witchcraft.conf /root/.witchcraft/witchcraft.conf && sed -i s:pushbullet:Git:g /root/.witchcraft/witchcraft.conf && sed -i s:Sabayon:Qacheck:g /root/.witchcraft/witchcraft.conf && rm -rfv /App-witchcraft-master && rm -rfv /witchcraft.tar.gz
# Display some news items
# Finalization
RUN env-update
