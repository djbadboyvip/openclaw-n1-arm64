# 使用官方 OpenClaw ARM64 镜像（slim 版本）
FROM ghcr.io/openclaw/openclaw:main-slim

# 安装 locales、tzdata 以及 Telegram 插件可能需要的系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    tzdata \
    ca-certificates \
    ffmpeg \          # Telegram 音频/视频处理
    curl \            # 调试工具（可选）
    && rm -rf /var/lib/apt/lists/*

# 配置 locale
RUN echo "zh_CN.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen zh_CN.UTF-8 \
    && update-locale LANG=zh_CN.UTF-8

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 语言环境变量
ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

# 安装 Telegram 插件（使用 npm 全局安装）
# 注意：官方镜像可能已包含 Node.js 和 npm，直接运行
RUN npm install -g @openclaw/plugin-telegram@latest

# 暴露默认端口
EXPOSE 18789

# 保留官方默认的 CMD
# CMD ["gateway", "run"]
