
FROM python:3.9-alpine3.13
LABEL maintainer="alaani.hiba@gmail.com"
ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN apk add --no-cache gcc musl-dev libffi-dev

RUN python -m ensurepip && \
    python -m pip install --upgrade pip virtualenv && \
    python -m virtualenv /py

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \ 
    apk add --update --force --no-cache postgresql-client && \
    apk add --update --force --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \ 
    if [ "$DEV" = "true" ]; \
       then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \  
    rm -rf /tmp && \ 
    apk del .tmp-build-deps && \
    adduser \
      --disabled-password \
      --no-create-home \
      django-user

ENV PATH="/py/bin:$PATH"

USER django-user