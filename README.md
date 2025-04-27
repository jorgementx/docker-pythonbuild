
# PythONBUILD

Alpine based image for autoinstalling locked dependencies with `uv` by leveraging `ONBUILD` instructions. Image can be found in <https://hub.docker.com/r/jorgementx/pythonbuild>.

## HOW TO USE

> [!IMPORTANT] 
> `pyproject.toml` and `uv.lock` files are expected to be found in the directory of the build context.

### Simple script:

```Dockerfile
FROM jorgementx/pythonbuild:3.13-alpine

COPY --chown=app app.py .

CMD ["python", "app.py", "--help"]
```

### Django application

```Dockerfile
ARG PYTHON_VERSION={{python_version}}
FROM jorgementx/pythonbuild:${PYTHON_VERSION}-alpine


RUN apk update && \
    apk add bash nginx libgcc libpq

RUN apk add --no-cache geos gdal #geodjango

COPY --chown=app --chmod=744 docker/docker-entrypoint.sh .
COPY --chown=app docker/supervisor.conf .
COPY docker/nginx_conf/default.conf /etc/nginx/conf.d/default.conf
COPY docker/nginx_conf/nginx.conf /etc/nginx/nginx.conf
COPY --chown=app django_proj/ .

RUN mkdir logs tmp

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["supervisord", "-c", "supervisor.conf"]
```
