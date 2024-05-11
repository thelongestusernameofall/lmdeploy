#!/bin/bash

server_ip=127.0.0.1
server_port=3334
model_name=llama3
curl http://{$server_ip}:{$server_port}/v1/models


curl http://{$server_ip}:{$server_port}/v1/chat/completions \
	  -H "Content-Type: application/json" \
	  -d '{
                  "model": "llama3",
                  "messages": [{"role": "user", "content": "<|im_start|>system:你是一个乐于助人的助理.<|im_end|><|im_start|>user:给我讲一个大灰狼吃掉了喜羊羊，被美羊羊暴打的故事。<|im_end|><|im_start|>assistant:"}],
		  "temperature": 0.8,
		  "n":1,
		  "stop":["<|im_end|>"]
	   }'

