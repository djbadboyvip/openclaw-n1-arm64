# 基础镜像（官方支持，绝对能拉取）
FROM node:22-bookworm-slim

# 汉化 + 时区
ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    TZ=Asia/Shanghai \
    OPENCLAW_PLUGINS_ENTRIES=telegram

# 安装依赖 + 中文支持
RUN apt-get update && apt-get install -y --no-install-recommends \
    git locales \
    && locale-gen zh_CN.UTF-8 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 克隆官方源码（核心！）
RUN git clone https://github.com/openclaw-project/openclaw.git /app
WORKDIR /app

# 安装生产依赖
RUN npm install -g pnpm && pnpm install --prod

# 启动
CMD ["node", "src/index.js"]
