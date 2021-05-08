# 
# Multi architecture MySQL docker image
# Copyright 2021 Jamiel Sharief
#

FROM jamielsharief/mysql:latest

# ENV DATE_TIMEZONE UTC
# ENV DEBIAN_FRONTEND=noninteractive

# # RUN groupadd -r mysql && useradd -r -g mysql mysql

# # Try to fix failures  ERROR: executor failed running [
ENV DOCKER_BUILDKIT=0
ENV COMPOSE_DOCKER_CLI_BUILD=0


ARG NODE_VERSION=14.16.0
RUN apt-get update
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

COPY blog-mid /blog/blog-server

WORKDIR /blog/blog-server
RUN npm i -g yarn
RUN npm i -g pm2
RUN yarn install


ADD ./start.sh /
USER root 
RUN chmod 755 /start.sh

EXPOSE 3306 33060
CMD ["/bin/bash", "/start.sh"]

# CMD ["mysqld"]