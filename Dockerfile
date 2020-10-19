FROM circleci/node:14.14.0


# Installing serverless framework
RUN sudo npm update -g && \
    sudo npm install -g serverless

# Installing serverless framework plugins
RUN sudo npm install serverless-aws-documentation --seve-dev  && \
    sudo npm install serverless-step-functions --save-dev --unsafe-perm=true --allow-root && \
    sudo npm install serverless-python-requirements

# Installing python3
RUN sudo apt-get update -y && sudo apt-get install -yq wget build-essential gcc zlib1g-dev

WORKDIR /tmp/
RUN wget https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz \
    && tar zxf Python-3.7.9.tgz \
    && cd Python-3.7.9 \
    && ./configure \
    && sudo make altinstall
ENV PYTHONIOENCODING "utf-8"

RUN sudo ln /usr/local/bin/python3.7 /usr/local/bin/python3
RUN sudo ln /usr/local/bin/pip3.7 /usr/local/bin/pip3

# Installing AWS client
RUN sudo pip3 install awscli

WORKDIR /
