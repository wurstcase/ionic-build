FROM ubuntu:18.04

ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip" \
    ANDROID_HOME="/opt/android" \
    ANDROID_SDK_MANAGER="/opt/android/tools/bin/sdkmanager" \
    NPM_VERSION="6.14.2" \
    NODEJS_VERSION="13.10.1" \
    IONIC_VERSION="6.2.1"

# Install necessary packages
RUN dpkg --add-architecture i386 && apt-get update && apt-get -y install apt-utils && apt-get install -y wget curl lftp unzip git npm openjdk-8-jdk wine-stable

# Install Android SDK
RUN cd /opt && \
    mkdir android && cd android && \
    wget -O tools.zip ${ANDROID_SDK_URL} && \
    unzip tools.zip && \
    rm tools.zip && \
    yes | ${ANDROID_SDK_MANAGER} "platforms;android-28" "platforms;android-29" "build-tools;28.0.3" "build-tools;29.0.3"

# Install npm, Node.js and Ionic
RUN npm i -g npm@${NPM_VERSION} && \
    npm i -g n && \
    n ${NODEJS_VERSION} && \
    npm i -g @ionic/cli@${IONIC_VERSION} && \
    npm i -g cordova
