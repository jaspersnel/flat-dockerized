# Dockerized FLAT (FoLiA Linguistic Annotation Tool)

This repository aims to put the FLAT infrastructure online a bit more easily.
For now, it's really only tested as a localized system, running off of docker-compose.
This should be expanded to a proper installation in, for example, kubernetes with a proper SQL database as backend.

## Running the infrastructure

The easiest way to get an installation of FLAT going is through docker compose. 
Simply download this repository and run:

```bash
docker compose up -d
```

This will bring FLAT online at http://localhost:8000. The username/password will be admin/admin.

## Building and using the individual docker images

The containers can be built using:

```bash
docker build -t username/flat -f flat.Dockerfile .
docker build -t username/docserve -f docserve.Dockerfile .
```

To get them to run together, a few things need to be considered:

- Both need to share a volume, mounted to `/data/` on each container
- FLAT needs to access docserve at port `8080`
- The development django server in FLAT runs at port `8000` by default
- The username for the `admin` user is given in `DJANGO_SUPERUSER_PASSWORD`
- The hostname of docserve is given to FLAT in `FOLIADOCSERVE_HOST` (default `host.docker.internal`)

This leads to this set of commands, for example.

```bash
docker volume create docserve
docker run --rm -v docserve:/data/ --name docserve jaspersnel/docserve
docker run --rm -v docserve:/data/ -p 8000:8000 -e DJANGO_SUPERUSER_PASSWORD=admin -e FOLIADOCSERVE_HOST=docserve --link docserve jaspersnel/flat
```