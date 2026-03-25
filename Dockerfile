# 使用官方 OpenClaw ARM64 镜像（slim 版本）
FROM ghcr.io/openclaw/openclaw:main-slim

# 安装 locales 和 tzdata（官方镜像可能已有，但为了确保 locale 生成，显式安装）
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    tzdata \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 配置 locale（Debian 标准方式）
RUN echo "zh_CN.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen zh_CN.UTF-8 \
    && update-locale LANG=zh_CN.UTF-8

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 设置语言环境变量
ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

# 如果官方镜像默认用户不是 openclaw，可创建（根据实际情况调整）
# 官方镜像可能已存在用户 openclaw，检查 /etc/passwd 或文档确认
# 这里假设官方镜像已创建 openclaw 用户且工作目录为 /app，保持原样即可

# 暴露默认端口（官方镜像可能已 EXPOSE，但重复无害）
EXPOSE 18789

# 保持官方镜像的 CMD 或 ENTRYPOINT（通常已设置）
# 如果不确定，可保留官方默认启动命令，或显式指定
# CMD ["gateway", "run"]
