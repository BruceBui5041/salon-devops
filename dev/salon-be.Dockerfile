FROM golang:latest

ARG GITHUB_TOKEN
ARG REPO_URL

# Install git
RUN apt-get update && apt-get install -y git

# Configure git with token
RUN git config --global url."https://${GITHUB_TOKEN}@github.com/".insteadOf "https://github.com/"

# Set working directory
WORKDIR /usr/src/app

# Clone the repository
RUN git clone ${REPO_URL} .

# Download dependencies
RUN go mod download

# Build the application
RUN go build -o main .

# Command to run the application
CMD ["./main"]