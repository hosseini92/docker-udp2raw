# docker-udp2raw

![Docker Pulls](https://img.shields.io/docker/pulls/dogbutcat/docker-udp2raw) ![Docker Image Version (latest by date)](https://img.shields.io/docker/v/dogbutcat/docker-udp2raw)

## Change Log

> 2023-12

- update udp2raw to 20230206.0

> 2021-09

- update udp2raw version

> 2020-06

- update script

> 2019-03

- update udp2raw

## Introducing

this image is based on alpine image & you need basic docker knowledge. You can get it from Google or [Git-book](https://yeasy.gitbooks.io/docker_practice/) for Chinese Learning. Then DON'T ASK ME! :D

## Word first

this is for udp2raw usage. Build-in version is [Here](https://github.com/wangyu-/udp2raw/releases/tag/20230206.0)

## How To Use It

you can replace the entry point with (reference [here](https://docs.docker.com/engine/reference/run/#entrypoint-default-command-to-execute-at-runtime))

- `udp2raw_x86`
- `udp2raw_arm`
- `udp2raw_amd64_hw_aes`
- `udp2raw_arm_asm_aes`
- `udp2raw_mips24kc_be`
- `udp2raw_mips24kc_be_asm_aes`
- `udp2raw_x86_asm_aes`
- `udp2raw_mips24kc_le`
- `udp2raw_mips24kc_le_asm_aes`

### Server

```sh
name_server="docker-udp2raw-server"
bin_server=udp2raw_amd64 # or udp2raw_arm ...
sudo docker run -d \
            --restart always \
            --network host \
            --name $name_server \
            docker-udp2raw:latest \
            $bin_server -s -l 0.0.0.0:8855 -r 127.0.0.1:7777 -k "passwds" --raw-mode icmp --fix-gro --sock-buf 10240 --cipher-mode xor --auth-mode simple
```

### Client

```sh
name_client="docker-udp2raw-client"
bin_client=udp2raw_amd64 # or udp2raw_arm ...
sudo docker run -d \
            --restart always \
            --network host \
            --cap-add NET_ADMIN \
            --name $name_client \
            docker-udp2raw:latest \
            $bin_client -c -l 0.0.0.0:3333 -r 127.0.0.1:8855  -k "passwds" --raw-mode icmp --fix-gro --sock-buf 10240 --cipher-mode xor --auth-mode simple
```

### Notice

because udp2raw running on level 2, if not work correct, ~~maybe~~ **MUST** need add `--net=host`/`--cap-add=NET_ADMIN` or `network_mode:"host"`/`cap_add: NET_ADMIN` in compose **AND** remember to bypass udp port `1024-65535` from firewall
