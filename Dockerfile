# =======================================================
# this is a multi task dockerfile using node image running "npm run build" 
# then copying /build directory over to nginx container.
# =======================================================
# node image
# copy package.json first and run install so we don't have to do this step
# everytime there is a change in the project files.

FROM node:18-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build


# nginx image
FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html
