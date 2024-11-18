FROM golang:latest

ARG GITHUB_TOKEN
ARG REPO_URL

# Install git
RUN apt-get update && apt-get install -y git

# Verify build args are passed correctly
RUN if [ -z "$GITHUB_TOKEN" ]; then \
    echo "GITHUB_TOKEN is not set" && exit 1; \
    fi && \
    if [ -z "$REPO_URL" ]; then \
    echo "REPO_URL is not set" && exit 1; \
    fi

# Configure git with token
RUN git config --global url."https://${GITHUB_TOKEN}@github.com/".insteadOf "https://github.com/"

# Set working directory
WORKDIR /usr/src/app

# Clone the repository
RUN git clone ${REPO_URL} .

# Download dependencies
RUN go mod download

# # Build the application
# RUN go build -o main .

# # Command to run the application
# CMD ["./main"]

CMD ["go", "run", "main.go"]