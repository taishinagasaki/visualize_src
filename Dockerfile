FROM centos:7

# 必要なパッケージをインストール
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install git make autoconf curl wget openssl openssh-server
RUN yum -y install gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel sqlite-devel bzip2 graphviz

# DEBUG
RUN yum -y install net-tools vim nc

# yum clean
RUN yum clean all
#RUN yum makecache fast

# set ruby version to be installed
ENV ruby_ver="2.3.8"
## locale
ENV LANG=en_US.UTF-8
#
## install ruby & bundler
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
#
RUN echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init --no-rehash -)"' >> /etc/profile.d/rbenv.sh
#
RUN source /etc/profile.d/rbenv.sh; rbenv install ${ruby_ver}; rbenv global ${ruby_ver}; rbenv local ${ruby_ver}
RUN source /etc/profile.d/rbenv.sh; gem update --system; gem install bundler --force
#
### Your application should be placed inside /home/app.
COPY Gemfile /home/app/webapp/Gemfile
COPY Gemfile.lock /home/app/webapp/Gemfile.lock
COPY visualize_test.rb /home/app/webapp/visualize_test.rb

### タイムゾーンをJSTに設定
ENV TZ=Asia/Tokyo
##
WORKDIR /home/app/webapp
##
RUN source /etc/profile.d/rbenv.sh; bundle install

