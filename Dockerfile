FROM python:3.7
WORKDIR /usr/src

COPY ./requirements.txt /usr/src/requirements.txt
RUN pip install -r requirements.txt

RUN jupyter nbextension install --user https://rawgithub.com/minrk/ipython_extensions/master/nbextensions/toc.js
RUN curl -L https://rawgithub.com/minrk/ipython_extensions/master/nbextensions/toc.css > $(jupyter --data-dir)/nbextensions/toc.css
RUN jupyter nbextension enable toc

WORKDIR /usr/src/app

ENTRYPOINT ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]