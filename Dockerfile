FROM ubuntu:18.04

# Install coq e python
RUN apt-get update && apt-get install -y coq coqide python3-dev python3 libzmq3-dev build-essential python2.7
RUN apt-get update && apt-get install -y python3-pip

# Install java
RUN apt-get update && apt-get install -y openjdk-11-jdk

# Install scala
RUN apt-get update && apt-get install -y wget
RUN wget https://downloads.lightbend.com/scala/2.11.0/scala-2.11.0.tgz && tar -xvzf scala-2.11.0.tgz && rm scala-2.11.0.tgz
ENV SCALA_HOME=/scala-2.11.0
ENV export PATH=$PATH:$SCALA_HOME/bin:$PATH

# Install Ruby
RUN apt-get update && apt-get install -y libtool libffi-dev ruby ruby-dev make
RUN apt-get update && apt-get install -y libzmq3-dev libczmq-dev

# Install Nodejs
RUN apt-get update && apt-get install -y nodejs npm

# Install jupyter and python dependency
WORKDIR /usr/src/app
COPY ./requirements.txt /usr/src/app/requirements.txt
RUN pip3 install -r requirements.txt

# Configure jupyter plugin for install extension
RUN jupyter contrib nbextension install --user
RUN jupyter nbextensions_configurator enable --user

# Configure coq (proof assistant)
RUN python3 -m coq_jupyter.install

# Configure sos (for multi lenguage into a notebook)
RUN python3 -m sos_notebook.install

# Configure Java
COPY ijava-1.3.0 ./ijava-1.3.0
RUN cd ijava-1.3.0 && python3 install.py --sys-prefix

# Configure Scala
ADD almond .
RUN ./almond --install

# Configure Ruby
RUN gem install cztop
RUN gem install iruby --pre
RUN iruby register --force

# Configure javascript
RUN npm install -g ijavascript  --zmq-external
RUN ijsinstall

#clean up, no need to clobber the image with python2
RUN apt-get autoremove -y python

CMD jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root --NotebookApp.token=''