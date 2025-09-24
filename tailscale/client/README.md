启动容器后输入命令

```shell
docker exec tailscale tailscale up --authkey=tskey-auth-XXXXX --hostname=xxxx  --accept-dns=false --accept-routes=true --advertise-routes=10.0.0.0/24
```

对于较新版本的系统开启 IP Forwarding

```shell
cat >/etc/sysctl.d/99-tailscale.conf <<'EOF'
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
EOF
```

对于较老版本的系统开启 IP Forwarding

```shell
cat >/etc/sysctl.conf <<'EOF'
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
EOF
```