import http.client
import json

conn = http.client.HTTPConnection("10.178.11.72", 3335)
payload = json.dumps({
   "model": "qwen110b",
   "input_ids": [
      108386,
      103924,
      3837,
      26288,
      104949
   ]
})
headers = {
   'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
   'Content-Type': 'application/json',
   'Accept': '*/*',
   'Host': '10.178.11.72:3335',
   'Connection': 'keep-alive'
}
conn.request("POST", "/v1/decode", payload, headers)
res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))