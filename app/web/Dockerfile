# Use official Node.js LTS as base image (small, maintained, secure)
FROM node:24-alpine AS base

# Set working directory inside container
WORKDIR /app

# Install dependencies only (leverage caching)
COPY package*.json ./
RUN npm ci --only=production

# Copy app source code
COPY . .

# Ensure non-root user for security
USER node

# Expose app port (defined via env)
EXPOSE 3000

# Environment variables (default values can be overridden at runtime)
ENV NODE_ENV=production \
    PORT=3000 \
    API_HOST=https://toptal.pototskyy.net

# Run app
CMD ["npm", "start"]