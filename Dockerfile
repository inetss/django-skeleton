FROM alpine:3.4

RUN apk add --no-cache \
		bash \
		gcc \
		libjpeg-turbo-dev `# for Pillow` \
		linux-headers `# for uwsgi` \
		memcached \
		musl-dev `# stdio.h` \
		nginx \
		postgresql-dev \
		python3 \
		python3-dev \
		sudo \
		supervisor \
		zlib-dev `# for Pillow` && \
	pip3 install --no-cache-dir --upgrade pip && \
	sed -i 's/localhost/_/' /etc/nginx/nginx.conf && \
	sed -i '$iinclude /app/docker/nginx/*.conf;' /etc/nginx/nginx.conf && \
	ln -snf /app/docker/supervisor.d /etc/supervisor.d && \
	adduser -S app

# This fails randomly, so run separately.
RUN pip3 install --no-cache-dir --disable-pip-version-check uwsgi

WORKDIR /app
CMD /app/docker/entrypoint.sh
EXPOSE 80

COPY requirements.txt /app/
# LIBRARY_PATH is needed for Pillow to discover zlib
RUN LIBRARY_PATH=/lib:/usr/lib pip3 install --no-cache-dir --disable-pip-version-check -r /app/requirements.txt

COPY . /app/
