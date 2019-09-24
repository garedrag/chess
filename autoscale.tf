provider "aws" {
  region     = "eu-central-1"
   
}

data "aws_availability_zones" "all" {}
### Creating EC2 instance
resource "aws_instance" "web" {
  ami                    = "${lookup(var.amis, var.region)}"
  count                  = "${var.counts}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  source_dest_check      = false
  instance_type          = "t2.micro"
  tags = {
    Name      = "${format("chess-web-%03d", count.index + 1)}"
    ita_group = "Lv-428"
  }
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  volume_tags = {
    "ita_group" = "Lv-428"
  }
}

### Creating Security Group for EC2
resource "aws_security_group" "instance" {
  name = "gare-terraform-example-instance-Trevis5"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    ita_group = "Lv-428"
  }
}

## Creating Launch Configuration
resource "aws_launch_configuration" "example" {
  image_id        = "${lookup(var.amis, var.region)}"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.instance.id}"]
  key_name        = "${var.key_name}"
  user_data       = <<-EOF
              #!/bin/bash
			  sudo yum install -y gcc-c++ make
              curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash -
		      sudo yum -y install nodejs
			  sudo yum -y install git
			  sudo yum -y install mc
			  sudo git clone https://github.com/garedrag/chess.git
			  cd /chess
			  sudo npm install
			  npm build
			  sudo npm run build
              npm start & sudo npm run client
		EOF
  lifecycle {
    create_before_destroy = true
  }
}

## Creating AutoScaling Group
resource "aws_autoscaling_group" "example" {
  launch_configuration = "${aws_launch_configuration.example.id}"
  availability_zones   = "${data.aws_availability_zones.all.names}"
  min_size             = 2
  max_size             = 10
  load_balancers       = ["${aws_elb.example.name}"]
  health_check_type    = "ELB"
  tag {
    key                 = "Name"
    value               = "chess-Lv-428"
    propagate_at_launch = true
  }
}

## Security Group for ELB
resource "aws_security_group" "elb" {
  name = "gare-terraform-example-elb-Trevis3"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    ita_group = "Lv-428"
  }
}
### Creating ELB
resource "aws_elb" "example" {
  name               = "terraform-asg-example-Trevis4"
  security_groups    = ["${aws_security_group.elb.id}"]
  availability_zones = "${data.aws_availability_zones.all.names}"
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60
    interval            = 300
    target              = "HTTP:8080/"
  }
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "8080"
    instance_protocol = "http"
  }
  listener {
    lb_port           = 8080
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
  tags = {
    ita_group = "Lv-428"
  }
}
