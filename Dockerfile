# Latest long term support image on smallest base distro 
FROM node:12.14-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install app dependencies via apk and npm
# --no-cache: download package index on-the-fly, no need to cleanup afterwards
# --virtual: bundle packages, remove whole bundle at once, when done
RUN apk --no-cache --virtual build-dependencies add \
  python \
  make \
  g++ \
  && npm ci --only=production \
  && apk del build-dependencies

# Copy remaining bundle
COPY . .

EXPOSE 1337

CMD [ "node", "./server.js"]
