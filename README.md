# terraria-server

Quickly deploy a dedicated Terraria server to Proxmox as an LXC container

## Pre-requisites

### Required Pre-requisites

- Have a Proxmox host with storage
  - My LXC storage disk is sitting at 1.4G used with the [Advanced deployment](#advanced-deployment)
- Download the dedicated server zip file from the link at the bottom of [this page](https://www.terraria.org/) and place it somewhere accessible from your PVE host. I put mine in `/mnt/pve/terraria` (NFS mount).

### Optional Pre-requisites

- If you already have a world, make it accessible from your host (mount the remote storage or store the world file locally on the host)
- Set up your firewall NAT and policies to allow 7777 to the host
- Set up DNS (I use Cloudflare and the `ddclient` docker container) to make it easy to get to the world from the internet

## Deployment

### Simple Deployment

Skip to the next section to see my deployment, which has more features.

#### Create Terraria Server

This creates an LXC container with the following parameters:

- OS: Rocky Linux 8
- Storage: 4GB on local-lvm
- IP: 10.1.15.50 with no VLAN
- Host directory `/mnt/pve/terraria` will map to `/mnt/terraria` in the container

```sh
pct create 1550 /var/lib/vz/template/cache/rockylinux-8-default_20210929_amd64.tar.xz \
  --arch amd64 \
  --ostype centos \
  --hostname terraria50 \
  --cores 2 \
  --memory 2048 \
  --swap 0 \
  --storage local-lvm \
  --rootfs 4 \
  --password $password \
  --net0 name=eth0,bridge=vmbr0,firewall=0,gw=10.1.15.1,ip=10.1.15.50/24,type=veth \
  --mp0 /mnt/pve/terraria,mp=/mnt/terraria \
  --unprivileged 1 \
  --onboot 1 &&\
  pct start 1550 &&
  sleep 10 &&\
  pct exec 1550 -- bash -c\
      "sudo dnf -y update &&\
      dnf -y install vim git wget epel-release openssh-server tmux unzip &&\
      systemctl start sshd &&\
      systemctl enable sshd &&\
      cp /mnt/terraria/terraria-server-*.zip . &&\
      unzip terraria-server-*.zip &&\
      cd 1432/Linux &&\
      chmod +x TerrariaServer.bin.x86_64 &&\
      mkdir -p ~/.local/share/Terraria/Worlds/ &&\
      ln -s /mnt/terraria/rakara/Rakara.wld ~/.local/share/Terraria/Worlds/"
```

### Advanced Deployment

#### Copy key to PVE host

`scp ~/.ssh/id_rsa.pub root@10.1.20.10:/root/.ssh/id_rsa.pub`

#### Create Terraria Server

This creates an LXC container with the following parameters:

- OS: Rocky Linux 8
- Storage: 4GB on local-lvm
- IP: 10.1.15.50/24 on VLAN 15
- Host directory `/mnt/pve/terraria` will map to `/mnt/terraria` in the container

Other:

- Installs the Alacritty terminfo into the container (optional)
- Since the host `/mnt/pve/terraria` directory is an NFS mount from my NAS, and the NAS is backed up, I don't have to worry about backing up this ephemeral Terraria server.
- Installs extra stuff for persistent tmux

```sh
pct create 1550 /var/lib/vz/template/cache/rockylinux-8-default_20210929_amd64.tar.xz \
  --arch amd64 \
  --ostype centos \
  --hostname terraria50 \
  --cores 2 \
  --memory 2048 \
  --swap 0 \
  --storage local-lvm \
  --rootfs 4 \
  --password $password \
  --ssh-public-keys /root/.ssh/id_rsa.pub \
  --net0 name=eth0,bridge=vmbr0,firewall=0,gw=10.1.15.1,ip=10.1.15.50/24,tag=15,type=veth \
  --mp0 /mnt/pve/terraria,mp=/mnt/terraria \
  --unprivileged 1 \
  --onboot 1 &&\
  pct start 1550 &&
  sleep 10 &&\
  pct exec 1550 -- bash -c\
      "sudo dnf -y update &&\
      dnf -y install vim git wget epel-release openssh-server tmux unzip &&\
      systemctl start sshd &&\
      systemctl enable sshd &&\
      git clone https://github.com/alacritty/alacritty.git &&\
      cd alacritty &&\
      tic -xe alacritty,alacritty-direct extra/alacritty.info &&\
      cp /mnt/terraria/terraria-server-*.zip . &&\
      unzip terraria-server-*.zip &&\
      cd 1432/Linux &&\
      chmod +x TerrariaServer.bin.x86_64 &&\
      mkdir -p ~/.local/share/Terraria/Worlds/ &&\
      ln -s /mnt/terraria/rakara/Rakara.wld ~/.local/share/Terraria/Worlds/ &&\
      git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &&\
      echo \"set -g @plugin 'tmux-plugins/tpm'\" >> ~/.tmux.conf &&\
      echo \"set -g @plugin 'tmux-plugins/tmux-sensible'\" >> ~/.tmux.conf &&\
      echo \"set -g @plugin 'tmux-plugins/tmux-resurrect'\" >> ~/.tmux.conf &&\
      echo \"run '~/.tmux/plugins/tpm/tpm'\" >> ~/.tmux.conf"
```

### Start the World

`ssh root@10.1.15.50`

`tmux`

`cd 1432/Linux`

`./TerrariaServer.bin.x86_64`
