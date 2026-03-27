# #Stage 1:
# FROM node:20-alpine AS build

# WORKDIR /task-board

# COPY package*.json ./
# RUN npm ci

# COPY . .
# RUN npm run build

# #Stage 2:
# FROM nginx:alpine-slim

# WORKDIR /task-board

# RUN npm install -g http-server

# COPY --from=build /task-board/dist/taskBoard/browser ./

# EXPOSE 7000

# CMD ["http-server", ".", "-p", "7000"]

# Stage 1: Build
FROM node:20-alpine AS build

WORKDIR /task-board

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Stage 2: Serve
FROM nginx:alpine-slim

COPY --from=build /task-board/dist/taskBoard/browser /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]