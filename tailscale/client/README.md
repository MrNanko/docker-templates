启动容器后输入命令

```shell
docker exec tailscale tailscale up --authkey=tskey-auth-XXXXX --hostname=xxxx  --accept-dns=false --accept-routes=true --advertise-routes=10.0.0.0/24
```

需要开启 IP Forwarding，参考 https://tailscale.com/kb/1019/subnets