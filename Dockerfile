# 1. Use official Python image
FROM python:3.11-slim

# 2. Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. Set work directory
WORKDIR /app

# 4. Install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install gunicorn  # for production server

# 5. Copy project
COPY . /app/

# 6. Collect static files
RUN python manage.py collectstatic --noinput

# 7. Expose port
EXPOSE 8000

# 8. Run the app
CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]
