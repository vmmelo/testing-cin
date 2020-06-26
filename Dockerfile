FROM python:3.7
WORKDIR /usr/src
COPY ./requirements.txt /usr/src/requirements.txt
RUN pip install -r requirements.txt
WORKDIR /usr/src/app
ENTRYPOINT ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]