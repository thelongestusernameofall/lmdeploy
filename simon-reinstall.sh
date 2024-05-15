#!/bin/bash

## 环境变量设置
export NCCL_ROOT_DIR=/usr  # 通常不需要指定到 build 目录
export NCCL_LIBRARIES=/usr/lib/x86_64-linux-gnu

# 第一步：重新创建build目录，如果已经存在则删除
if [ -d "build" ]; then
    rm -rf build
fi
mkdir build

# 第二步：pushd到build目录并执行命令
pushd build

# 运行generate.sh脚本
sh ../generate.sh

# 运行ninja命令并安装
ninja -j$(nproc) && ninja install

# 返回原始目录
popd

# 第三步：执行pip install -e .
pip install -e .
