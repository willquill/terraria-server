# terraria-server

<<<<<<< HEAD
Quickly deploy a dedicated Terraria server via Docker, Docker Compose, or to Proxmox as an LXC container
=======
<<<<<<< HEAD
Quickly deploy a dedicated Terraria server via Docker
=======
Quickly deploy a dedicated Terraria server via Docker, Docker Compose, or to Proxmox as an LXC container
>>>>>>> 9617697 (update README after moving releases to different branches)
>>>>>>> 9420af8 (update README after moving releases to different branches)

## How to use this repo

See the different branches and releases for different READMEs on how to deploy.

<<<<<<< HEAD
## License
=======
<<<<<<< HEAD
- Your host is ready to run docker containers
- You have a world file already

If you don't have a world file already, checkout the [beardedio/terraria](https://github.com/beardedio/terraria) GitHub page for instructions on creating a world.

## Deployment

### Prepare Server Files

Included in this repo are two files:

- serverconfig.txt
- banlist.txt

Copy these files as well as your world file to a destination path you'd like to store your world.

My path: `/mnt/media/games/terraria/rakara`

Things you may want to modify in serverconfig.txt before running the server:

- motd (message of the day)
- password

Take a look at the other options in the file as well.

### Prepare ddclient

If you want to use a hostname to connect to your server instead of IP address, and if you use Cloudflare as your nameserver, do this:

`mv ddclient-sample.conf ddclient.conf`

Then edit the `ddclient.conf` file for your needs

### Option 1: Docker Run

Set the location of your world file:

`export HOST_WORLD_PATH=/mnt/media/games/terraria/rakara`

`export HOST_WORLD_FILENAME=Rakara.wld`

```sh
docker run -dit \
  --name=terraria-rakara \
  -v $HOST_WORLD_PATH:/config \
  -e world=$HOST_WORLD_FILENAME \
  -p 7777:7777 \
  beardedio/terraria:vanilla-latest
```

### Option 2: Docker Compose

Create the env file

`cp .env-sample .env`

Modify `.env`:

`vim .env`

If you dont want to use ddclient, just delete that container from the `docker-compose.yml` file.

Start it:

`docker-compose up -d`

## Credit

Helpful resources:

- [beardedio/terraria](https://hub.docker.com/r/beardedio/terraria/)
- [ryansheehan/terraria](https://github.com/ryansheehan/terraria)

## LICENSE
>>>>>>> 9420af8 (update README after moving releases to different branches)

=======
## License

>>>>>>> 9617697 (update README after moving releases to different branches)
MIT License
