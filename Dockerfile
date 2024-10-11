# Use a lightweight version of Node.js (Alpine is minimal and fast)
FROM node:16-alpine

# Set the working directory inside the container to /app
WORKDIR /app

# Copy package.json and lock file to install dependencies (This improves caching)
COPY package.json package-lock.json ./

# Install dependencies (runs 'npm install')
RUN npm install

RUN mkdir node_modules/.cache && chmod -R 777 node_modules/.cache


# Copy all application files from the host machine to the container
# Only happens if the previous steps are successful, helping cache dependencies
COPY . .

# Expose the port on which the React development server will run
EXPOSE 3000

# Create a non-root user for security (running as root is not safe)
RUN adduser -D react-user

# Switch to the non-root user to run the app more securely
USER react-user

# Default command to start the React app in development mode (supports hot-reloading)
CMD ["npm", "start"]
