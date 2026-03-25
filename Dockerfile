# ✅ N1 最优：官方精简版镜像
FROM ghcr.io/openclaw/openclaw:main-slim

# 启用简体中文 + 时区（适配 N1）
ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    TZ=Asia/Shanghai

# 【关键修复】精简版用 apk 安装依赖（替代 apt-get）
# 先判断包管理器类型，兼容所有精简镜像
RUN if [ -x "$(command -v apk)" ]; then \
        # Alpine 系（main-slim 大概率是这个）
        apk add --no-cache tzdata locales && \
        echo "zh_CN.UTF-8 UTF-8" > /etc/locale.conf && \
        locale-gen zh_CN.UTF-8; \
    elif [ -x "$(command -v apt-get)" ]; then \
        # Debian/Ubuntu 系（备用）
        apt-get update && apt-get install -y --no-install-recommends locales && \
        locale-gen zh_CN.UTF-8 && \
        apt-get clean && rm -rf /var/lib/apt/lists/*; \
    fi

# 仅保留 Telegram 插件，禁用其他无用插件
ENV OPENCLAW_PLUGINS_ENTRIES=telegram
