FROM maven:3.6-openjdk-11
MAINTAINER olhtbr@gmail.com

RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y --no-install-recommends git jq wget unzip openssh-client make g++ libstdc++6 software-properties-common openssl libssl-dev && \
    git config --global user.email "git@localhost" && \
    git config --global user.name "git" && \
    mkdir -p /opt/resource/git && \
    wget https://github.com/concourse/git-resource/archive/master.zip -O /opt/resource/git/git-resource.zip && \
    unzip /opt/resource/git/git-resource.zip -d /opt/resource/git && \
    mv /opt/resource/git/git-resource-master/assets/* /opt/resource/git && \
    mv /opt/resource/git/git-resource-master/scripts/install_git_crypt.sh /opt/resource/git && \
    rm -r /opt/resource/git/git-resource.zip /opt/resource/git/git-resource-master && \
    bash /opt/resource/git/install_git_crypt.sh

ADD settings.xml /usr/share/maven/conf/
ADD check in out /opt/resource/

ENV MAVEN_REPO /root/.m2/repository

# Disable parent image entrypoint as it copies only a reference config
ENTRYPOINT [""]
