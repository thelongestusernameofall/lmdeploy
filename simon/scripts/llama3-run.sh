#!/bin/bash

export  CUDA_VISIBLE_DEVICES=4,3

function tensor_parallel() {
    local device_count

    # 检查CUDA_VISIBLE_DEVICES是否被设置
    if [ -n "$CUDA_VISIBLE_DEVICES" ]; then
        # 将环境变量的值按逗号分隔，并计算设备数目
        device_count=$(echo $CUDA_VISIBLE_DEVICES | tr ',' '\n' | wc -l)
    else
        # 自动检测当前机器的CUDA设备数目
        # 使用nvidia-smi命令检测，需确保系统已安装NVIDIA驱动及nvidia-smi工具
        device_count=$(nvidia-smi --list-gpus | wc -l)
    fi

    # 计算不超过device_count的最大2的指数
    local power=1
    while [ $((power * 2)) -le $device_count ]; do
        power=$((power * 2))
    done

    echo $power
}

tp=$(tensor_parallel)
echo "Using ${tp} GPU devices"

model_path=/data2/simon/models/hongshu/Hongshu2-32B-chat-v1_0-240418
model_path=/data2/simon/models/QWen/Qwen-72B-Chat-Int4
model_path=/data2/simon/models/QWen/Qwen-7B-Chat
model_path=/data2/simon/models/QWen/Qwen1_5-32B-Chat
#model_path=/data2/simon/models/llama/llama3/Meta-Llama-3-8B-Instruct
model_path=/data2/simon/models/llama/llama3/Meta-Llama-3-70B-Instruct

model_name=inf
pct=0.7 #gpu pct

#lmdeploy serve api_server ${model_path} --server-port 3333 --model-name ${model_name} --tp ${tp} 

lmdeploy serve gradio ${model_path} --server-port 3333 --model-name ${model_name} --tp ${tp} --chat-template llama3.json --cache-max-entry-count ${pct}
#--quant-policy 8
