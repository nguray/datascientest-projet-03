FROM python:3.6-alpine
LABEL maintainer="Raymond NGUYEN"

WORKDIR /opt 

RUN pip install flask==1.1.2

EXPOSE 8080

ENV ODOO_URL="https://www.odoo.com/fr_FR"
ENV PGADMIN_URL="https://www.pgadmin.org/"

COPY . /opt/

ENTRYPOINT ["python", "app.py"]