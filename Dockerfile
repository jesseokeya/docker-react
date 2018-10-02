# ----- Builder ----

FROM node:alpine as builder

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

# ----- Nginx ------

FROM nginx

# For port mapping in aws elastic beanstalk
EXPOSE 80

COPY --from=builder /app/build/ /usr/share/nginx/html