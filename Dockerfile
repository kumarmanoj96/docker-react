#1.This is build phase
FROM node:alpine as builder_phase
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#2.This is the run phase.We will copy the build directory from the above builder_phase stage(that is 
# the only thing we care about)
FROM nginx
#copying from a stage
COPY --from=builder_phase /app/build /usr/share/nginx/html 