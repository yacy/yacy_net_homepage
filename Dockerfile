# build:   docker build -t yacy_net_homepage .
# check:   docker run -it --rm yacy_net_homepage /bin/bash
# deploy:  docker run -d -p 8080:8080 --rm --name yacy_net_homepage yacy_net_homepage
# cleanup: docker image prune --filter label=stage=builder

# first stage: building
FROM python:slim-buster AS builder

WORKDIR /tmp

COPY cinder-superhero ./cinder-superhero
COPY docs ./docs
COPY mkdocs.yml .

RUN pip install mkdocs
RUN mkdocs build --verbose --clean --strict

# second stage: hosting
FROM bitnami/nginx:latest AS stage

EXPOSE 8080 8443
COPY --from=builder /tmp/site /opt/bitnami/nginx/html
