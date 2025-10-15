#1. Base file
FROM node:18-slim

#working
WORKDIR /app

#copy the code from source to conatiner directory

COPY . .

#run the build command and install dependencies

RUN npm install && npm run build

#exposing port
EXPOSE 3000

#serving the app and keep it running
CMD ["npm","run","dev"]
