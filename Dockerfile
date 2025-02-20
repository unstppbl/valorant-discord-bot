# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install required system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip && rm -rf /var/lib/apt/lists/*

# Copy only requirements.txt first (to leverage Docker cache)
COPY requirements.txt .

# Install dependencies (cached unless requirements.txt changes)
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . .

# Copy the .env file explicitly
COPY .env .env

# Ensure the bot script is executable
RUN chmod +x bot.py

# Set environment variables (for immediate logging)
ENV PYTHONUNBUFFERED=1

# Run the bot
CMD ["python3", "bot.py"]
