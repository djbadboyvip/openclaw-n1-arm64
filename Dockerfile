# 【修复】换成正确的公开基础镜像
FROM ghcr.io/openclaw-project/openclaw:latest

# 启用简体中文
ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    TZ=Asia/Shanghai

# 预装依赖
RUN apt-get update && apt-get install -y --no-install-recommends locales \
    && locale-gen zh_CN.UTF-8 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 默认禁用所有无用插件
ENV OPENCLAW_PLUGINS_ENTRIES=telegram
