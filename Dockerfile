# DOCKER-VERSION 0.5.3
FROM ubuntu:12.10
MAINTAINER John Yi "john.yi@rackspace.com"

RUN apt-get -y update
RUN apt-get -y install curl build-essential libxml2-dev libxslt-dev git
RUN apt-get -y install python openssh-server
RUN curl https://pypi.python.org/packages/source/s/setuptools/setuptools-1.1.6.tar.gz | tar xvzf -;cd setuptools-1.1.6;sudo python setup.py install
# RUN tar xvzf setuptools-1.1.6.tar.gz
# RUN sudo python setup.py install
RUN sudo easy_install pip
RUN sudo pip install python-novaclient
RUN sudo pip install python-swiftclient
RUN sudo pip install python-heatclient
RUN sudo pip install python-cinderclient
RUN sudo pip install python-keystoneclient
RUN sudo pip install pyrax
RUN sudo git clone https://github.com/calebgroom/clb.git;cd clb;sudo python setup.py install
RUN sudo mkdir /root/.ssh
ADD . /root/.ssh
RUN sudo mkdir /run/sshd
RUN echo "source openstackrc" >> /root/.bashrc
ADD ./openstackrc /root/
EXPOSE 2222
CMD ["/usr/sbin/sshd", "-D", "-p 2222"]
