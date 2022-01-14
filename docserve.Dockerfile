FROM python:3.9

# Install git for changes tracking in documents
RUN apt update && apt install git && rm -rf /var/lib/apt-lists/*
RUN git config --global user.email "folia@docserve.example" && git config --global user.name "Docserve"

RUN mkdir /data/

# Install requirements
WORKDIR /app
COPY docserve-containerfiles/requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

EXPOSE 8080
CMD foliadocserve -d /data/ -p 8080 --git