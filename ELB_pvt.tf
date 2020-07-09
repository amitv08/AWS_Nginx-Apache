#Create Private Elastic Loadbalance
resource "aws_elb" "web_pvt_elb" {
  name     = "web-pvt-elb"
  internal = true
  security_groups = [
    "${aws_security_group.private_elb_http.id}"
  ]
  subnets = [
    "${aws_subnet.private_ap_south_1a.id}"
  ]

  # ,    "${aws_subnet.private_ap_south_1b.id}"  
  cross_zone_load_balancing = true
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:8080/"
  }
  listener {
    lb_port           = 8080
    lb_protocol       = "http"
    instance_port     = "8080"
    instance_protocol = "http"
  }
}