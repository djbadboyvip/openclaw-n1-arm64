FROM ghcr.io/openclaw/openclaw:main-slim

# 切换到 root 安装系统依赖和插件
USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    tzdata \
    ca-certificates \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# 配置 locale
RUN echo "zh_CN.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen zh_CN.UTF-8 \
    && update-locale LANG=zh_CN.UTF-8

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

# 全局安装 Telegram 插件（root 权限）
RUN npm install -g @openclaw/plugin-telegram@latest

# 切换回官方镜像默认用户（假设为 openclaw）
USER openclaw

EXPOSE 18789
# CMD 保留官方默认
