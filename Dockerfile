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
RUN source ~/.tnvm/tnvm.sh && tnvm -v && \
# 安装node
tnvm install node-$NODE_VERSION && tnvm use node-$NODE_VERSION && node -v && \
# 设置淘宝镜像
npm install -g cnpm --registry=https://registry.npm.taobao.org && \
tnvm install alinode-$ALINODE_VERSION && tnvm use alinode-$ALINODE_VERSION && which node && \
# 安装监控和pm2
npm install @alicloud/agenthub pm2 yarn -g --registry=https://registry.npm.taobao.org && which yarn && \
# 设置环境变量
export NODE_LOG_DIR=/tmp && export ENABLE_NODE_LOG=YES \
&& ln -s $ALINODE_BIN_DIR/* /usr/bin   

RUN which node
