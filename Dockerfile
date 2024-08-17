# Stage 1: Build stage
FROM python:3.9-slim as builder

# Set the working directory
WORKDIR /data

# Install dependencies with no cache
RUN pip install --no-cache-dir django==3.2

# Copy the project files to the working directory
COPY . .

# Run database migrations
RUN python manage.py migrate

# Stage 2: Final stage using distroless
FROM gcr.io/distroless/python3

# Copy files from the builder stage
COPY --from=builder /data /data

# Set the working directory in the final image
WORKDIR /data

# Expose the application port
EXPOSE 8000

# Run the Django server
CMD ["manage.py", "runserver", "0.0.0.0:8000"]
