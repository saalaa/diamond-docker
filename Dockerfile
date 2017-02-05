FROM alpine:3.5

RUN apk update
RUN apk upgrade
RUN apk add python3
RUN apk add postgresql-dev
RUN apk add git
RUN apk add build-base
RUN apk add python3-dev
RUN apk add libffi-dev

RUN git clone https://github.com/saalaa/diamond

RUN pip3 install -r /diamond/requirements.txt

# System cleanup
RUN apk del --rdepends --purge \
  git build-base python3-dev libffi-dev
RUN rm -rf /var/cache/apk/*

WORKDIR /diamond

COPY docker-entrypoint.sh /diamond/docker-entrypoint.sh

ENTRYPOINT ["/diamond/docker-entrypoint.sh"]
