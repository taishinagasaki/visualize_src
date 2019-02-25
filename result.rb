#! /usr/local/rbenv/versions/2.3.8/bin/ruby
require "bundler/setup"
require 'cgi'
cgi = CGI.new
print "Content-Type: text/html\n\n"
print "<html>\n"
print "<head>\n"
print "<title>CGI Test</title>\n"
print "</head>\n"
print "<body>\n"
print "<a href=\"/form.cgi\">\"こちらのページから画像が見れます\"</a>"
print "</body>\n"
print "</html>\n"
$src = cgi["sub"]

require './visualize_mod.rb'
include Visualize

begin
Visualize.visualize($src)
 print "成功！画像を確認してみよう！"
rescue Exception => e
 print "失敗！もう一度やり直してね</br>"
 print "#{e}</br>"
end
