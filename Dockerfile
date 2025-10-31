# base image for nodejs

FROM node:18-slim AS builder

#creating work directory for the container

WORKDIR /app
# installing dependencies 

RUN npm install

#copy the application files from local to container direcotry

COPY . .

#---------------- Stage:2 Runtime--------------
FROM node:18-alpine 

WORKDIR /newappcontainer

#copy the compiled dependencies from builder

COPY --from=builder /app /newappcontainer/

#exposing port 

EXPOSE 3000

#serving the app and keep container running

CMD ["npm","run","dev"]
