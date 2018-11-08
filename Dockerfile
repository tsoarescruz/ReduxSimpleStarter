
# set the base image to Debian
# https://hub.docker.com/_/debian/
FROM debian:latest

MAINTAINER Thiago Soares <thiagosoarescruz0@gmail.com>

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh


ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

# update the repository sources list
# and install dependencies
RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 build-essential libssl-dev apt-utils \
    nodejs mysql-client mercurial subversion libpq-dev nodejs-legacy \
    mysql-client curl && apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/*

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 10.13.0

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# install node and npm LTS version
#RUN source $NVM_DIR/nvm.sh \
#    && nvm install --lts \
#    && nvm alias default lts/* \
#    && nvm use default


# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# confirm installation
RUN node -v
RUN npm -v

RUN mkdir ReduxSimpleStarter

ADD . /ReduxSimpleStarter

EXPOSE 8080

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash"]
CMD node start
