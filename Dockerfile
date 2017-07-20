FROM library/celery

MAINTAINER Sahand Hariri sahandha@gmail.com

RUN sudo apt-get install -y python-pip python-dev build-essential \
&& pip install --upgrade pip \
&& pip install jupyter

RUN jupyter notebook --generate-config --allow-root \
&& sed -i -e 's/#c.NotebookApp.ip\ =\ \x27localhost\x27/c.NotebookApp.ip\ =\ \x27*\x27/g' ~/.jupyter/jupyter_notebook_config.py \
&& sed -i -e 's/#c.NotebookApp.open_browser\ =\ True/c.NotebookApp.open_browser\ =\ False/g' ~/.jupyter/jupyter_notebook_config.py \
&& sed -i -e 's/#c.NotebookApp.port/c.NotebookApp.port/g' ~/.jupyter/jupyter_notebook_config.py \
&& sed -i -e 's/#c.NotebookApp.allow_root\ =\ False/c.NotebookApp.allow_root\ =\ True/g' ~/.jupyter/jupyter_notebook_config.py

EXPOSE 8888

ADD celery_conf.py /data/celery_conf.py
ADD run_tasks.py /data/run_tasks.py
ADD run.sh /usr/local/bin/run.sh

ENV C_FORCE_ROOT 1

CMD ["/bin/bash", "/usr/local/bin/run.sh"]

