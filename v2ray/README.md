# 用法

- 关掉 **vmess-aead** 加密

  > 注释 `docker-compose.yml` 文件里面的环境变量 `V2RAY_VMESS_AEAD_FORCED=false` ，节点参数 `alterId=0`

- 校对时间

  - **timedatectl**

    ```shell
    timedatectl  # 查看时间各种状态
    timedatectl list-timezones  # 列出所有时区
    timedatectl set-local-rtc 1   # 将硬件时钟调整为与本地时钟一致，0为设置为UTC时间
    timedatectl set-timezone Asia/Shanghai  # 设置系统时区为亚洲上海
    ```

  - **ntp**

    ```shell
    # centos7
    yum install -y ntp
    systemctl enable ntpd
    ntpdate -q 0.rhel.pool.ntp.org
    systemctl restart ntpd / service ntpd restart
    
    # Debian 9 / Ubuntu 16
    apt-get install -y ntp
    systemctl enable ntp
    systemctl restart ntp
    ```

- 修改 **config.json**

  ```
  # 反代理端口，对应nginx配置中的proxy_pass
  inbounds.port
  # 反代理location的url，对应nginx配置中的location
  inbounds.streamSettings.wsSettings.path
  ```

- **Nginx** 反代理

  ```conf
  server {    
      listen       443 ssl;    
      server_name  domain.com;
      ssl_certificate    /etc/nginx/ssl-certificates/domain.com.pem;
      ssl_certificate_key    /etc/nginx/ssl-certificates/domain.com.key;
      ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
      ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
      ssl_prefer_server_ciphers on;
      ssl_session_cache shared:SSL:10m;
      ssl_session_timeout 10m;
      error_page 497  https://$host$request_uri;
  
      location /mask {
          proxy_pass       http://v2ray:12580;
          proxy_redirect             off;
          proxy_http_version         1.1;
          proxy_set_header Upgrade   $http_upgrade;
          proxy_set_header Connection "upgrade";
          proxy_set_header Host      $http_host;
      }
  }
  
  server {
      listen       80;
      server_name  domain.com;
      rewrite ^(.*)$ https://${server_name}$1 permanent;
  }
  ```