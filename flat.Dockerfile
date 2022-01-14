FROM python:3.9

WORKDIR /app

# Install requirements
COPY flat-containerfiles/requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

# Set up environment for FLAT
RUN mkdir /data/
ENV PYTHONPATH /app/
ENV DJANGO_SETTINGS_MODULE settings

COPY flat-containerfiles/ /app/

# Run migrations, create super user, and start the server
# Should refactor this dependent on setup maybe?
CMD django-admin migrate --run-syncdb ; django-admin createsuperuser --noinput --username admin --email admin@example.com ; django-admin runserver 0:8000