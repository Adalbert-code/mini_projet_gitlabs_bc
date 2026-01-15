# Grab the latest alpine images
FROM python:3.12-alpine

# Install python and pip with bash
RUN apk add --no-cache python3 py3-pip bash

# Copy requirements first (better layer caching)
COPY ./webapp/requirements.txt /tmp/requirements.txt

# Install dependencies
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Copy application code
COPY ./webapp /opt/webapp/

WORKDIR /opt/webapp

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

# Gunicorn doit cibler "application", car ton wsgi.py dit:
# from app import app as application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "wsgi:application"]