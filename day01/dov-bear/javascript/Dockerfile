ARG VER=18.2.0

FROM node:${VER}

LABEL developer=roy

## building the image
# create a working directory
WORKDIR /app

# make sure that curl is installed
RUN apt update && apt install curl

# copy the files from local into the container
ADD main.js .
ADD package-lock.json .
ADD package.json .
ADD public public
ADD views views

# install the packages
RUN npm ci

## running the image
ENV APP_PORT=3000

EXPOSE ${APP_PORT}

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
 CMD curl -s http://localhost:${APP_PORT}/healthz || exit 1

# run the application
ENTRYPOINT [ "node","main.js" ]