FROM node:18-alpine

RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

COPY --chown=nodejs:nodejs . .

USER nodejs

ENV PORT=80
ENV API_HOST=https://api.toptal.pototskyy.net

EXPOSE 80

CMD ["npm", "start"]
