# ---------------- Stage 1: Build ----------------
FROM node:18-slim AS builder

# Create working directory
WORKDIR /app

# Copy only package.json and package-lock.json first (for better caching)
COPY package*.json ./

# Install dependencies
RUN npm ci --omit=dev   # production-safe install (skips dev dependencies)

# Copy the rest of the source code
COPY . .

# Optional: If you build TypeScript or transpile, do it here
# RUN npm run build

# ---------------- Stage 2: Runtime ----------------
FROM node:18-alpine

WORKDIR /app

# Copy only necessary files from builder (e.g., built code + node_modules)
COPY --from=builder /app /app

# Expose the app port
EXPOSE 3000

# Start the application (use npm start for production)
CMD ["npm", "start"]
