# VisualizeSrc
## Description
Write down Ruby source code in form then push submit-button, then application give the flowchart image on the page. This consists of Ruby, Gem VisualizeRuby, Apache(CGI), Dockerfile basically.
The reason why created is that it should be easier and more helpful for reverse-engineering.
Required specific environment for Gem VisualizeRuby, especailly Ruby 2.3.8. Did want make the tool without the unnecessary, so it is without Rails.
That's why this offered with Dockerfile.
##### [Gem VisualizeRuby](https://github.com/zeisler/visualize_ruby). Thanks [Zeisler](https://github.com/zeisler).
### How it works
![class_worker.gif](https://qiita-image-store.s3.amazonaws.com/0/367758/fe016e54-b1e6-1a79-7672-4650c280f46d.gif)
### How to Use
１． Pull this repository.
`git pull https://github.com/taishinagasaki/visualize_src.git`
２． Build Docker image
`docker build -t repository_name/image_name:tag_name . --no-cache=true`
3. Check image built
`docker images`
4. Run Docker Container with port 80 and privileged-mode for using systemctl.
`docker run --privileged -d -p 80:80 --name container_name repository_name/image_name:tag_name /sbin/init`
5. Check the container's status UP
`docker start <container_id>`
6. Be in the container/server
`docker exec -it <container_id> /bin/bash`
7. Start Apache
`systemctl start httpd`
8. Checke the Apache active
`systemctl start httpd`
9. Open the url in the browser
`localhost/form.cgi`
##### Any Question?? or Contribution??
Feel Free!!Thanks.
