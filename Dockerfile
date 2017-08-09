FROM python:3.5.3-slim


MAINTAINER Sahand Hariri sahandha@gmail.com
USER root
RUN pip install Celery
ADD celery_conf.py /data/celery_conf.py
ADD run_tasks.py /data/run_tasks.py
ADD run.sh /usr/local/bin/run.sh

ENV C_FORCE_ROOT 1

WORKDIR /data

CMD ["/bin/bash", "/usr/local/bin/run.sh"]
