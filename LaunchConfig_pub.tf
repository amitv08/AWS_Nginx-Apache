#Create Launch Configuration
resource "aws_launch_configuration" "web" {
  name_prefix = "web-"

  image_id      = var.image_id
  instance_type = "t2.micro"
  key_name      = var.key_name

  security_groups             = ["${aws_security_group.allow_http.id}"]
  associate_public_ip_address = true

  user_data = <<USER_DATA
#!/bin/bash
yum update
yum -y install nginx
# echo "$(curl http://169.254.169.254/latest/meta-data/local-ipv4)" > /usr/share/nginx/html/index.html
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.org
sed -i '47a\proxy_pass http://${aws_elb.web_pvt_elb.dns_name}:8080;' /etc/nginx/nginx.conf
sed -i 's/root/#root/g' /etc/nginx/nginx.conf
 
chkconfig nginx on
service nginx start
setsebool httpd_can_network_connect on -P
  USER_DATA

  lifecycle {
    create_before_destroy = true
  }
}
