FROM node:12.2.0 
WORKDIR /app
COPY . /app
EXPOSE 9000
RUN npm install
RUN npm start


