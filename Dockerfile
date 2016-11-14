FROM alpine:3.4
# Use alpine v3.5 for uwsgi-python3 (get rid of this once there is an official Docker tag)
RUN sed -i -e 's/v3\.4/v3.5/' /etc/apk/repositories

WORKDIR /app
CMD docker/entrypoint.sh
EXPOSE 80

# for zlib
ENV LIBRARY_PATH=/lib:/usr/lib

RUN apk add --no-cache \
		bash \
		build-base \
		libjpeg-turbo-dev `# for Pillow` \
		nginx \
		postgresql-dev \
		python3 \
		python3-dev \
		sudo \
		supervisor \
		uwsgi \
		uwsgi-python3 \
		zlib-dev `# for Pillow` && \
	pip3 install --no-cache-dir --upgrade pip setuptools && \
	ln -snf /app/docker/supervisor.d /etc/supervisor.d && \
	ln -snf /app/docker/nginx/nginx.conf /etc/nginx && \
	adduser -S app

COPY requirements.txt ./
RUN pip3 install --no-cache-dir --disable-pip-version-check -r requirements.txt

COPY . ./
