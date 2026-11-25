# Use an official lightweight Python image
FROM python:3.12-slim-bookworm

# Prevent Python from writing .pyc files and enable unbuffered logging
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies if needed (e.g., git, curl, or build tools)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the server source code
COPY . .

# Create a non-root user for security and switch to it
RUN useradd -u 10001 mcpuser && chown -R mcpuser:mcpuser /app
USER mcpuser

EXPOSE 8000

# Set the entrypoint to run your MCP script
ENTRYPOINT ["python", "-u", "main.py"]

