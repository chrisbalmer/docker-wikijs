FROM ubuntu AS locales

RUN apt update && apt install -y git
RUN mkdir /wiki && \
    cd /wiki && \
    git clone https://github.com/Requarks/wiki-localization.git

FROM requarks/wiki:2.5.170

RUN mkdir /wiki/data/sideload && \
    echo "offline: \$(OFFLINE)" >> /wiki/config.yml

COPY --from=locales /wiki/wiki-localization/*.json /wiki/data/sideload/

WORKDIR /wiki
CMD ["node", "server"]