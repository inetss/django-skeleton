FROM alpine:3.4

WORKDIR /app
CMD docker/entrypoint.sh
EXPOSE 80

# for zlib
ENV LIBRARY_PATH=/lib:/usr/lib

RUN apk add --no-cache \
		bash \
		build-base \
		libjpeg-turbo-dev `# for Pillow` \
		linux-headers `# for uwsgi` \
		nginx \
		postgresql-dev \
		python3 \
		python3-dev \
		sudo \
		supervisor \
		zlib-dev `# for Pillow` && \
	pip3 install --no-cache-dir --upgrade pip setuptools && \
	`# uwsgi compile fails randomly, see https://github.com/unbit/uwsgi/issues/1318` && \
	(while true; do pip3 install --no-cache-dir --disable-pip-version-check --verbose uwsgi && break; done) && \
	sed -i '$iinclude /app/docker/nginx/*.conf;' /etc/nginx/nginx.conf && \
	ln -snf /app/docker/supervisor.d /etc/supervisor.d && \
	adduser -S app

COPY requirements.txt ./
RUN pip3 install --no-cache-dir --disable-pip-version-check -r requirements.txt

COPY . ./
