FROM alpine:3.5

RUN apk update
RUN apk upgrade
RUN apk add py2-pip
RUN apk add git
RUN apk add build-base
RUN apk add postgresql-dev
RUN apk add python2-dev
RUN apk add libffi-dev

RUN git clone https://github.com/saalaa/diamond

WORKDIR /diamond

RUN pip install -r requirements.txt

# System cleanup
RUN apk del --rdepends --purge \
  git build-base postgresql-dev python2-dev libffi-dev
RUN rm -rf /var/cache/apk/*
