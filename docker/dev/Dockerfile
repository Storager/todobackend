FROM storager/todobackend-base:latest

RUN apt-get update && \
    apt-get install -qy python-dev

# Activate virtual environment and install wheel support
RUN . /appenv/bin/activate && \
    pip install wheel --upgrade

# PIP environment variables (NOTE: must be set after installing wheel)
ENV WHEELHOUSE=/wheelhouse PIP_WHEEL_DIR=/wheelhouse PIP_FIND_LINKS=/wheelhouse XDG_CACHE_HOME=/cache

# OUTPUT: Build artefacts (Wheels) are output here
VOLUME /wheelhouse

VOLUME [ "/build" ]

# OUTPUT: Test reports are output here
VOLUME /reports

COPY scripts/test.sh /usr/local/bin/test.sh
RUN chmod +x /usr/local/bin/test.sh

ENTRYPOINT ["test.sh"]
CMD ["python", "manage.py", "test", "--noinput"]

COPY src /application
WORKDIR /application