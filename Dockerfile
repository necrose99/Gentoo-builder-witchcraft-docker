FROM gentoo/stage3-amd64:latest

# installing witchcraft deps
RUN emerge sudo dev-perl/Class-Load 
RUN emerge dev-perl/Class-Load-XS 
RUN emerge dev-perl/List-MoreUtils 
RUN emerge dev-perl/DateTime-Local 
RUN emerge dev-perl/libwww-perl 
RUN emerge App-cpanminus

# downloading and install witchcraft
RUN wget 'https://codeload.github.com/Spike-Pentesting/App-witchcraft/tar.gz/master' -O witchcraft.tar.gz && tar xvf witchcraft.tar.gz && cd App-witchcraft-master && cpanm --installdeps -n . && cpanm .

# configuring witchcraft
RUN mkdir -p /root/.witchcraft && cp -rfv /App-witchcraft-master/witchcraft.conf /root/.witchcraft/witchcraft.conf && sed -i s:pushbullet:Git:g /root/.witchcraft/witchcraft.conf && sed -i s:Sabayon:Qacheck:g /root/.witchcraft/witchcraft.conf && rm -rfv /App-witchcraft-master && rm -rfv /witchcraft.tar.gz
