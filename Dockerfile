# Use a Foundry-compatible base image
FROM ghcr.io/foundry-rs/foundry:latest

# Set the working directory inside the container
WORKDIR /app

# Copy your local project files into the container
COPY . .

# Install any necessary dependencies (optional for Foundry projects)
RUN forge install

# Default command to execute your script
CMD ["bash", "./deploy.sh"]
