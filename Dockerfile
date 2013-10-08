# DOCKER-VERSION 0.5.3
FROM ubuntu:12.10
MAINTAINER John Yi "john.yi@rackspace.com"

RUN apt-get -y update
RUN apt-get -y install curl build-essential libxml2-dev libxslt-dev git zlib1g-dev libssl-dev
RUN apt-get -y install python openssh-server python-dev
RUN curl https://pypi.python.org/packages/source/s/setuptools/setuptools-1.1.6.tar.gz | (cd /root;tar xvzf -;cd setuptools-1.1.6;python setup.py install)
RUN easy_install pip
RUN pip install python-novaclient
RUN pip install python-swiftclient
RUN pip install python-heatclient
RUN pip install python-cinderclient
RUN pip install python-keystoneclient
RUN pip install pyrax
RUN pip install ansible
# Setting the $HOME variable here
ENV HOME /root
RUN git clone https://github.com/calebgroom/clb.git $HOME/clb;cd $HOME/clb;python setup.py install
RUN git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
RUN $HOME/.rbenv/bin/rbenv install 1.9.3-p448
RUN $HOME/.rbenv/versions/1.9.3-p448/bin/gem install rumm
RUN mkdir $HOME/.ssh
ADD ./authorized_keys $HOME/.ssh/
RUN mkdir /run/sshd
RUN echo >> $HOME/.bashrc
RUN echo "# Added by docker setup" >> $HOME/.bashrc
RUN echo "export PATH=$PATH:$HOME/.rbenv/bin:$HOME/.rbenv/shims:$HOME/.rbenv/versions/1.9.3-p448/bin" >> $HOME/.bashrc
RUN echo "source openstackrc" >> $HOME/.bashrc
ADD ./openstackrc $HOME/
EXPOSE 2222
CMD ["/usr/sbin/sshd", "-D", "-p 2222"]
