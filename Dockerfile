# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install required system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-venv python3-pip && rm -rf /var/lib/apt/lists/*

# Copy the project files to the container
COPY . .

# Copy the .env file explicitly
COPY .env .env

# Install dependencies globally in the container
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Ensure the bot script is executable
RUN chmod +x bot.py

# Set environment variables (if needed)
ENV PYTHONUNBUFFERED=1

# Run the bot
CMD ["python3", "bot.py"]