# !!!THIS IS IN DEVELOPMENT!!!

# terraria-server

Quickly deploy a dedicated Terraria server to AWS.

Steps involved to deploy your server:

1. Modify variables.
2. Create and deploy your AMI.
3. Apply the Terraform.

## Costs Overview

AWS lets you use its services for [free](https://aws.amazon.com/free/) in three different ways:

- Free trials
- 12 months free
- Always free

This deployment uses both "12 months free" and "Always free" services

Services uses in this deployment:

- AWS DynamoDB (Always free)
  - To store Terraform state
- AWS CodePipeline (Always free)
  - Test our container before creating it
- AWS EC2 (12 months free)
  - Linux instance which will run the Terraria server
- AWS EBS (12 months free)
  - Storage volume for the EC2 instance
- AWS S3 (12 months free)
  - Storage for Terraria world backups

Something I'm considering adding later:

- AWS Pinpoint
  - Mobile notifications when players join world

## Pre-requisites

Although actually deploying the server is as easy as running `terraform apply`, you'll need to complete these pre-requisites:

1. Sign up for a new AWS account (to quality for the 12 months free).
    - If you want to use an AWS account you've had for more than 12 months, you will be billed for the use of EC2, EBS, and S3.
1. [Have Packer installed](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli).


## Prepare 
2. Manually create your DynamoDB table.






## Build your AMI

Hashicorp tutorial located [here](https://learn.hashicorp.com/tutorials/packer/aws-get-started-build-image?in=packer/aws-get-started).

What we're doing here:

- Specifying your AWS account credentials
- Creating an AMI on your AWS account for the Terraria server

### Install Packer

See instructions [here](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli).

I use openSUSE Tumbleweed, so I had to do follow the "Compile from source" instructions:

`sudo zypper install go`

`mkdir -p $(go env GOPATH)/src/github.com/hashicorp && cd $_`

`git clone https://github.com/hashicorp/packer.git && cd packer && make dev`

`sudo cp bin/packer /usr/local/bin`

### Export your environmental variables

`export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY`

`export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY`

### Initialize, format, validate, build

`packer init .`

`packer fmt .`

`packer validate .`

`packer build terraria-server.pkr.hcl`



## Deploy Latest Version

For a Docker environment, see the `environment/docker` branch

For a Proxmox (PVE) LXC environment, see the `environment/pve-lxc` branch

You can also see current and previous versions under Releases.

## License

MIT License
