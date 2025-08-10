# # Base nginx image
# FROM nginx:alpine

# # Copy custom nginx config
# COPY nginx.conf /etc/nginx/nginx.conf

# # Copy static app files to nginx html directory
# COPY app/ /usr/share/nginx/html/

# # Expose HTTP port
# EXPOSE 80


# Step 1: Build the React app
FROM node:18-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: Serve app using nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
