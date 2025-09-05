FROM python:3.9-slim

# Set work directory
WORKDIR /app/backend

# Install system dependencies for mysqlclient + netcat (for wait-for-db.sh)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       gcc \
       default-libmysqlclient-dev \
       pkg-config \
       netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files (including wait-for-db.sh)
COPY . .

# Make wait-for-db.sh executable
RUN chmod +x /app/backend/wait-for-db.sh

# Expose Django port
EXPOSE 8000

# Default command (can override in docker-compose.yml)
CMD ["./wait-for-db.sh", "python", "manage.py", "runserver", "0.0.0.0:8000"]
