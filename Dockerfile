FROM python:3.10-alpine

COPY . /app/

WORKDIR /app


ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_PASSWORD=admin_pass
ENV DJANGO_SUPERUSER_EMAIL=admin@mail.com

RUN pip install -r requirements.txt

RUN python manage.py collectstatic --no-input
RUN python manage.py migrate
RUN python manage.py createsuperuser --no-input

EXPOSE 8000

CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]
