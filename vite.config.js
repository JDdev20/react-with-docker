import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    host: '0.0.0.0',  // Esto permite el acceso desde la red
    watch: {
      usePolling: true,  // Esto asegura que Vite detecte cambios en el sistema de archivos dentro del contenedor
    },
  },
})
