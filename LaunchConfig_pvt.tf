#Create Launch Configuration
resource "aws_launch_configuration" "private_web" {
  name_prefix = "web-pvt-"

  image_id      = var.image_id
  instance_type = "t2.micro"
  key_name      = var.key_name

  security_groups = ["${aws_security_group.allow_http.id}"]

  user_data = <<USER_DATA
#!/bin/bash
yum update
yum -y install httpd
echo "Calling from $(curl http://169.254.169.254/latest/meta-data/local-ipv4) apache server" > /var/www/html/index.html
sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf
systemctl start httpd
systemctl enable httpd
  USER_DATA

  lifecycle {
    create_before_destroy = true
  }
}