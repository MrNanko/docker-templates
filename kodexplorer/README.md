# 用法

- 从容器中拷贝文件到宿主机

  ```shell
  docker run -itd --name kodexplorer kodcloud/kodexplorer
  docker cp kodexplorer:/var/www/html ./data
  docker cp kodexplorer:/var/www/html ./data
  docker stop kodexplorer && docker rm kodexplorer
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
  
      location / {
          proxy_pass       http://kodexplorer:80;
          proxy_redirect             off;
      }
  }
  
  server {
      listen       80;
      server_name  domain.com;
      rewrite ^(.*)$ https://${server_name}$1 permanent;
  }
  ```
  
  