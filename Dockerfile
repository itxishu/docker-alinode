FROM rdmix/ubuntu-base:v0.0.1

LABEL maintainer="starkwang wsd312@163.com"
LABEL name="alinode-base"
LABEL version="v0.0.1"
ENV ALINODE_VERSION v6.0.0
ENV NODE_VERSION v14.0.0
ENV ALINODE_BIN_DIR /root/.tnvm/versions/alinode/$ALINODE_VERSION/bin

SHELL ["/bin/bash", "--login", "-c"]

# install alinode
RUN wget -O- https://raw.githubusercontent.com/aliyun-node/tnvm/master/install.sh | bash

RUN echo 'export TNVM_DIR="/root/.tnvm"' >> ~/.bashrc

RUN source ~/.bashrc
RUN source ~/.tnvm/tnvm.sh \
    && tnvm install alinode-$ALINODE_VERSION \
    && tnvm use alinode-$ALINODE_VERSION \
    && tnvm install node-$NODE_VERSION && tnvm use node-$NODE_VERSION && node -v \
    && npm install @alicloud/agenthub -g \
    # && npm config set registry https://registry.npm.taobao.org \ 不建议设置，可以在项目里面设置
    && npm install pm2 -g --production \
    && npm install yarn -g --production

# echo env
RUN source ~/.tnvm/tnvm.sh \
    && node -v \
    && npm -v \
    && yarn -v \
    && tnvm -v \
    && which node \
    && which pm2

ENTRYPOINT ["/bin/bash"]
CMD ["source", "~/.tnvm/tnvm.sh"]
