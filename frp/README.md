# Usage

## Server

- Directory Structure

  ```
  frp
  ├── config
  │   └── frps.ini
  └── docker-compose.yml
  ```

- `frp/docker-compose.yml` reference example 

  ```
  version: "3.7"
  services:
    frp:
      image: leamx/frp
      hostname: frp
      container_name: frp
      restart: always
      ports:
        - 7000:7000
        - 7022:7022
        - 7500:7500
      volumes:
        - ./config/frps.ini:/opt/frp/frps.ini
      command: ["./frps", "-c", "/opt/frp/frps.ini"]
  ```
  
  The number of ports can be increased or decreased according to your needs.

- `frp/config/frps.ini` reference example

  ```
  [common]
  # The port bound to the client for communication
  bind_port = 7000
  # Configure a port for dashboard 
  dashboard_port = 7500
  # Dashboard's username and password are both optional
  dashboard_user = admin
  dashboard_pwd = admin
  # Used for client and server link identification key
  token = f6647e21-b7a2-46d2-8389-478fa36f6fca
  ```

## Client

- Directory Structure

  ```
  frp
  ├── config
  │   └── frpc.ini
  └── docker-compose.yml
  ```

- `frp/docker-compose.yml` reference example

  ```
  version: "3.7"
  services:
    frp:
      image: leamx/frp
      hostname: frp
      container_name: frp
      restart: always
      volumes:
        - ./config/frpc.ini:/opt/frp/frpc.ini
      command: ["./frpc", "-c", "/opt/frp/frpc.ini"]
  ```
  Since there are no other services except ssh in the example, there is no external port mapping.

- `frp/config/frpc.ini` reference example

  ```
  [common]
  # Server ip address
  server_addr = x.x.x.x
  # Consistent with the bind_port configured in the server frps.ini
  server_port = 7000
  # The token in frps.ini on the server side
  token = f6647e21-b7a2-46d2-8389-478fa36f6fca

  [ssh]
  # Connection agreement
  type = tcp
  # Intranet server ip address, for example 192.168.1.133
  local_ip = x.x.x.x
  # Intranet server ssh port number
  local_port = 22
  # The port the frp server listens on, which needs to be mapped in the docker-compose.yml of the server
  remote_port = 7022
  ```

# Github
For more examples see [github](https://github.com/fatedier/frp)