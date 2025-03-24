# Usage

- **File Tree**

  ```
  .
  ├── docker-compose.yml
  ├── Dockerfile
  └── rootfs
      ├── app
      │   ├── app.py
      │   ├── config.json
      │   ├── requirements.txt
      │   └── static
      └── etc
          ├── cont-init.d
          └── services.d
              └── app
                  └── run
  ```

- The `run` file must have executable permissions

  `chmod +x run`

  ```sh
  #!/usr/bin/with-contenv sh
  
  cd /app
  exec python3 app.py
  ```

  