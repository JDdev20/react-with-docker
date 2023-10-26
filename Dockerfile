# Usa una imagen de Node.js como base (versión lts-alpine)
FROM node:lts-alpine as build-stage

# Establece el directorio de trabajo
RUN mkdir app
# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de configuración de la aplicación
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto de los archivos
COPY . .

# Construye la aplicación
RUN npm run build

#---Despliegue con Nginx---
# Usa una imagen de Nginx como base
FROM nginx:1.25.3 as production-stage

# Copia el contenido de la carpeta dist a la carpeta de despliegue de Nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Copia el archivo de configuración de Nginx
EXPOSE 80

# Comando para iniciar la aplicación en modo producción con Nginx
CMD ["nginx", "-g", "daemon off;"]