# ✅ N1 首选：官方精简版镜像
FROM ghcr.io/openclaw/openclaw:main-slim

# 启用简体中文 + 时区（适配 N1）
ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    TZ=Asia/Shanghai

# 精简版镜像可能缺 locales，按需安装（仅装必要依赖）
RUN apt-get update && apt-get install -y --no-install-recommends locales \
    && locale-gen zh_CN.UTF-8 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 仅保留 Telegram 插件，禁用其他无用插件
ENV OPENCLAW_PLUGINS_ENTRIES=telegram
