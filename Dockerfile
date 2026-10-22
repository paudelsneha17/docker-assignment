# Use the official Node.js 16 image as the base image.
# This gives the container its own Node.js and npm, so Node does not
# need to be installed on the host machine.
FROM node:16

# Set the working directory inside the container.
# All following commands (COPY, RUN, CMD) run from /app.
WORKDIR /app

# Copy package.json (and package-lock.json if it exists) first.
# Copying these before the rest of the code lets Docker cache the
# dependency layer, so rebuilds are faster when only app code changes.
COPY package*.json ./
# Install the app's dependencies listed in package.json.
RUN npm install

# Copy all remaining application files into the working directory.
COPY . .

# Document that the app listens on port 3000 inside the container.
# The port still has to be mapped with -p when running the container.
EXPOSE 3000

# Start the application with npm start when the container launches.
CMD ["npm", "start"]