FROM jrei/systemd-ubuntu:22.04


RUN DEBIAN_FRONTEND="noninteractive" apt-get update

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \
      python3 \
      python3-distutils 

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py && \
    curl -sL --http1.1 https://cnfl.io/cli | sh -s -- -b /usr/local/bin v2.8.1 && \
    rm -fr /tmp/tmp.*
ENV pip_packages "\
  ansible==6.7.0 "

RUN pip3 install $pip_packages
WORKDIR /data
COPY tomcat_test.sh data/tomcat_test.sh
COPY tomcat_deploy.yml data/tomcat_deploy.yml
ENTRYPOINT [ "tomcat_test.sh" ]