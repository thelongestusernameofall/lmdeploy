#!/bin/bash

server_ip=10.178.11.72
server_port=3334
model_name=llama3

echo "===== model list ========"
echo ""
curl http://{$server_ip}:{$server_port}/v1/models
echo ""
echo "===== chat test ========="
echo ""
curl http://${server_ip}:${server_port}/v1/chat/completions \
           -H "Content-Type: application/json" \
           -d '{
                   "model": "llama3",
                   "messages": [{"role": "user", "content": "<|begin_of_text|><|start_header_id|>system<|end_header_id|>You are a chatbot who always response directly.<|eot_id|><|start_header_id|>user<|end_header_id|>请用中文给我讲一个大灰狼吃掉了喜羊羊，被美羊羊暴打的故事。<|eot_id|><|start_header_id|>assistant<|end_header_id|>"}],
                   "temperature": 0.8,
                   "n":1,
				   "max_tokens":125,
                   "stop":["<|eot_id|>"]
            }'
echo ""
echo "===== prompt test ========="
echo ""
			
curl http://${server_ip}:${server_port}/v1/completions \
 -H "Content-Type: application/json" \
 -d '{
    "model": "llama3",
    "prompt": "<|begin_of_text|><|start_header_id|>system<|end_header_id|>You are a chatbot who always response directly.<|eot_id|><|start_header_id|>user<|end_header_id|>请用中文给我讲一个大灰狼吃掉了喜羊羊，被美羊羊暴打的故事。<|eot_id|><|start_header_id|>assistant<|end_header_id|>",
    "max_tokens":125,
    "n":1,
    "temperature":0.8,
	"stop":["<|eot_id|>"]
}'
