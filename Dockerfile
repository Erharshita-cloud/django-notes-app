FROM python:3.9-slim

# Set work directory
WORKDIR /app/backend

# Install system dependencies for mysqlclient
RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Expose port
EXPOSE 8000

# Default command (can override in docker-compose)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
