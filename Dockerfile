# Use Ubuntu 20.04 as the base image
FROM ubuntu:22.04

# Set environment variables to prevent tzdata from asking for geographic location
ENV DEBIAN_FRONTEND=noninteractive

# Update the package lists
RUN apt-get update

# Install necessary packages
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y sudo build-essential php8.1 php8.1-dev g++ git make

# Create a directory for your extension in the Docker image
RUN mkdir /yourextension

# Copy your extension's source code into the Docker image
COPY . /yourextension

# Change the working directory to your extension's directory
WORKDIR /yourextension

# Build your extension
RUN make

# Install your extension
RUN make install

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
