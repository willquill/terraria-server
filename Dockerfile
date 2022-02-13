FROM alpine:3.11.6 AS base

RUN apk add --update-cache \
    unzip

# add the bootstrap file
COPY bootstrap.sh /terraria-server/bootstrap.sh

ENV DL_LINK=https://terraria.org/api/download/pc-dedicated-server/terraria-server-1432.zip
ENV DL_VERSION=1432
ENV DL_FILE=terraria-server-1432.zip

ADD $DL_LINK /$DL_FILE

RUN unzip /$DL_FILE -d /terraria && \
    mv /terraria/$DL_VERSION/Linux/* /terraria-server && \
    #Linux subfolder does not include any config text file, oddly.
    mv /terraria/$DL_VERSION/Windows/serverconfig.txt /terraria-server/serverconfig-default.txt && \
    chmod +x /terraria-server/TerrariaServer && \
    chmod +x /terraria-server/TerrariaServer.bin.x86_64

FROM mono:6.8.0.96-slim
LABEL maintainer="Will Coquillette <will@will.mx>"

# documenting ports
EXPOSE $PORT

# env used in the bootstrap
ENV LOGPATH=/terraria-server/logs
ENV WORLD_FILENAME=$WLD_FILE_HOST

VOLUME ["/root/.local/share/Terraria/Worlds", "/config", "/terraria-server/logs"]

COPY --from=base /terraria-server/ /terraria-server/

# Set working directory to server
WORKDIR /terraria-server

ENTRYPOINT [ "/bin/sh", "bootstrap.sh" ]

