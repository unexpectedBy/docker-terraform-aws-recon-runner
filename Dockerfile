FROM node:11-alpine

RUN true \
	&& apk add \
		--no-cache \
		--virtual .deps \
		build-base

RUN true \
	&& npm install -g pown \
	&& pown modules install @pown/aws

RUN true \
	&& apk del .deps

RUN true \
	&& apk add \
		--no-cache \
		ca-certificates \
		libstdc++

WORKDIR /run

ADD main.pown main.pown

WORKDIR /session

ENTRYPOINT ["time", "pown", "script", "/run/main.pown"]
