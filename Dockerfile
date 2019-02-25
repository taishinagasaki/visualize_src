FROM centos:7

# 必要なパッケージをインストール
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install git make autoconf curl wget openssl openssh-server
RUN yum -y install gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel sqlite-devel bzip2 graphviz
RUN yum -y install httpd

# DEBUG
RUN yum -y install net-tools vim nc

# yum clean
RUN yum clean all
#RUN yum makecache fast

# Delete httpd welcome page
RUN rm -f /etc/httpd/conf.d/welcome.conf

# set ruby version to be installed
ENV ruby_ver="2.3.8"
## locale
ENV LANG=en_US.UTF-8

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

# replace httpd config
COPY httpd_conf/cgi-enabled.conf /etc/httpd/conf.d/cgi-enabled.conf
COPY httpd_conf/httpd.conf /etc/httpd/conf/httpd.conf 

## static file should be placed inside /var/www/html
COPY form.cgi /var/www/html/form.cgi

## ruby application should be placed inside /var/www/cgi-bin/
COPY Gemfile /var/www/cgi-bin/Gemfile
COPY Gemfile.lock /var/www/cgi-bin/Gemfile.lock
COPY result.rb /var/www/cgi-bin/result.rb
COPY visualize_mod.rb /var/www/cgi-bin/visualize_mod.rb


### タイムゾーンをJSTに設定
ENV TZ=Asia/Tokyo
## 特にこれはどうでもいい
WORKDIR /var/www/cgi-bin

RUN source /etc/profile.d/rbenv.sh; rbenv exec bundle install

RUN chmod 757 /var/www/cgi-bin
RUN chmod 757 result.rb

#COPY startup.sh /startup.sh
#RUN chmod 744 /startup.sh
#CMD ["/startup.sh"]
