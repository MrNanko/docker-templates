# 用法

- 从容器中拷贝文件到宿主机

  ```shell
  docker run -itd --name nginx nginx:alpine
  docker cp nginx:/etc/nginx ./etc
  docker cp nginx:/usr/share/nginx ./share
  docker cp nginx:/var/log/nginx ./log
  docker stop nginx && docker rm nginx
  ```

  <details>
    <summary>All in One</summary>
    <pre><code> 
    docker run -itd --name nginx nginx:alpine && docker cp nginx:/etc/nginx ./etc && docker cp nginx:/usr/share/nginx ./share && docker cp nginx:/var/log/nginx ./log && docker stop nginx && docker rm nginx
    </code></pre>
  </details>

- 使用 **Nginx** 容器反代理其他 **Web** 项目

  在使用此 `docker-compose.yml` 之前，你需要创建一个名为 `nginx-net` 的 `docker network`

