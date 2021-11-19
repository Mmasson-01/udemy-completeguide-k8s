FROM node:alpine

ENV NODE_OPTIONS=--openssl-legacy-provider

# Prepare application work directory
WORKDIR /app

# Copy package.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application files
COPY . .

# Production build
RUN npm run build


FROM nginx
EXPOSE 3000

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=0 /app/build /usr/share/nginx/html
