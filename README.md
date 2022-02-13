# terraria-server

Quickly deploy a dedicated Terraria server to Proxmox as an LXC container

## Pre-requisites

### Required Pre-requisites

- Ready to run docker containers

## Deployment

### Docker Run

Set the location of your world file:

`WLD_DIR_HOST=/mnt/media/games/terraria/rakara`

`WLD_FILE_HOST=Rakara.wld`

*Will write the actual docker run command later...*

`docker run -d terraria:latest -p 7777:7777 -v $WLD_DIR_HOST:/root/.local/share/Terraria/Worlds -e WORLD_FILENAME=$WLD_FILE_HOST`

`sudo docker run -d --rm -p 7777:7777 -v $WLD_DIR_HOST:/root/.local/share/Terraria/Worlds terraria:latest WORLD_FILENAME=Rakara.wld`

WHY THE BELOW WITH DOCKER LOGS?!?

logpath=/terraria-server/logs
Server configuration not found, running with default server configuration.
Please ensure your desired serverconfig.txt file is volumed into docker: -v <path_to_config_file>:/config
No world file specified in environment WORLD_FILENAME.
Running server with command flags: WORLD_FILENAME=Rakara.wld
Error Logging Enabled.
Terraria Server v1.4.3.2


### Docker Compose

Create the env file

`cp .env-sample .env`

Modify `.env`:

`vim .env`

If you don't want to use ddclient, just delete that container from the `docker-compose.yml` file.

Start it:

`docker-compose up -d`

## Building from Source

### Build Dockerfile

`docker build . --tag terraria`

Verify the image exists now. It should be at the top of this list

`docker images`

### Publish Docker image

Tag the image

`docker tag terraria willquill/terraria:1.4.3.2`

Verify again to see the new tag

`docker images`

You may make mistakes, and you will want to build and tag over and over again. You can run the both the build and the tag commands with this script:

```sh
cat > build_and_tag.sh<< EOF
#!/bin/sh
docker build . --tag terraria
docker tag terraria willquill/terraria:1.4.3.2
EOF
```

Make it executable:

chmod +x build_and_tag.sh

Run it:

./build_and_tag.sh

## LICENSE

MIT License
