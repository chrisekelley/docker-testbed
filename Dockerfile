FROM chrisekelley/docker-testbed-support

# Setup Tangerine environment for Couch
ENV T_HOSTNAME local.tangerinecentral.org
ENV T_ADMIN admin
ENV T_PASS password
ENV T_COUCH_HOST localhost
ENV T_COUCH_PORT 5984
ENV T_ROBBERT_PORT 4444
ENV T_TREE_PORT 4445
ENV T_BROCKMAN_PORT 4446
ENV T_DECOMPRESSOR_PORT 4447

# Update apt
RUN apt-get update

# Install jdk7
# RUN apt-get -y install oracle-java7-installer
RUN apt-get -y install default-jdk

# Install android sdk
# FROM webratio/ant

# Installs Android SDK
#ENV ANDROID_SDK_FILENAME android-sdk_r24.3.4-linux.tgz
#ENV ANDROID_SDK_URL http://dl.google.com/android/${ANDROID_SDK_FILENAME}
#ENV ANDROID_API_LEVELS android-15,android-16,android-17,android-18,android-19,android-20,android-21, android-22
#ENV ANDROID_BUILD_TOOLS_VERSION 21.1.0
#ENV ANDROID_HOME /opt/android-sdk-linux
#ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
#RUN cd /opt && \
#    wget -q ${ANDROID_SDK_URL} && \
#    tar -xzf ${ANDROID_SDK_FILENAME} && \
#    rm ${ANDROID_SDK_FILENAME} && \
#    echo y | android update sdk --no-ui -a --filter tools,platform-tools,${ANDROID_API_LEVELS},build-tools-${ANDROID_BUILD_TOOLS_VERSION}

RUN curl http://dl.google.com/android/android-sdk_r24.3.4-linux.tgz > tmp/android-sdk.tgz
#RUN sudo mkdir /usr/local/bin/android-sdk-linux
RUN mkdir /usr/local/bin/android-sdk-linux
RUN tar xvf tmp/android-sdk.tgz -C /usr/local/bin
RUN chown -R root:root /usr/local/bin/android-sdk-linux
RUN chmod a+x /usr/local/bin/android-sdk-linux/tools/android
ENV PATH ${PATH}:/usr/local/bin/android-sdk-linux/tools:/usr/local/bin/android-sdk-linux/build-tools
RUN sudo sh -c "echo \"export PATH=$PATH:/usr/local/bin/android-sdk-linux/tools:/usr/local/bin/android-sdk-linux/build-tools \nexport ANDROID_HOME=/usr/local/bin/android-sdk-linux\" > /etc/profile.d/android-sdk-path.sh"
#RUN cd /usr/local/bin/android-sdk-linux/tools/ && echo y | /usr/local/bin/android-sdk-linux/tools/android update sdk -u -a --force -t "android-22,tools,platform-tools,build-tools-23.0.2"
RUN cd /usr/local/bin/android-sdk-linux/tools/ && echo y | /usr/local/bin/android-sdk-linux/tools/android update sdk -u -a --force -t "tools"
RUN cd /usr/local/bin/android-sdk-linux/tools/ && echo y | /usr/local/bin/android-sdk-linux/tools/android update sdk -u -a --force -t "platform-tools"
RUN cd /usr/local/bin/android-sdk-linux/tools/ && echo y | /usr/local/bin/android-sdk-linux/tools/android update sdk -u -a --force -t "android-22,build-tools-23.0.2"

# Installs i386 architecture required for running 32 bit Android tools
RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean

