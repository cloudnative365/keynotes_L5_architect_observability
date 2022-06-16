variable server_port {
  type    = number
  default = 8080
}

variable ssh_port {
  type    = number
  default = 22
}

variable instance_type_node {
  type    = string
  default = "t3.xlarge"
}

variable instance_ami {
  type    = string
  default = "ami-0b6da95c5acd0be7c"
}

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJE3IFld1B4Mu+7SGNQl/oc6yXDnr1YW2bPPlxha5O1oDk6c9aTHqqxcCROBIZRJESj31H4kXPIiDch3Bs3qsOHhDzao6vqddTDq6ONeykmKZH0MpVyowWjMlYBoi0kYX8lLxBIk+dX5GNd2zr91TEuJHPuQhgfsJaaQqKtPMrEu2KaI/Yel2qs/oZ0qif/SfFxaj6tQU3FcF+E3xYT+ww83fV93fsAh55y6cKmaWhlaWGu1ixrjdONgKZvtXJZnr6W4sRxo1ygtr8yS/Zl74ooWqp6gS9DRM0LY8rWPpEtxT8fwjt3ZrSmbsGpN0xD56Cfw66jn3cniOVH/BTNf/wkmtg7NutgFOa+592llXyJGPFHJkjzed3RfQwMZ+HdgtZZeAHwxKE8fWzVi9pOr1Ske7RwXGbEz9RC2mt3ITvFXX/unUf3Ow8LlOWgkbxe9q4OSWFMuuCLGOBO4D9Hpm8b20nrZhMBKIzy3BCdq5//ZLt85fiti0rYbUChiKu1pk= 29371962@qq.com"
}

resource "aws_instance" "jumpserver" {
  ami           = var.instance_ami
  instance_type = "t3.micro"
  key_name = "mykey"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.public.id]
  subnet_id = "${aws_subnet.public.id}"
  private_ip = "10.0.0.11"
  user_data = <<-EOF
        #!/bin/bash
        yum install -y net-tools vim wget epel-release
        EOF
  tags =  {
    Name = "jumpserver"
  }
}

resource "aws_instance" "node1" {
  ami           = var.instance_ami
  instance_type = var.instance_type_node
  associate_public_ip_address = true
  key_name = "mykey"
  vpc_security_group_ids = [aws_security_group.public.id]
  subnet_id = "${aws_subnet.private.id}"
  private_ip = "10.0.1.11"
  user_data = <<-EOF
        #!/bin/bash
        yum install -y net-tools vim wget epel-release
        mkdir /app
        mkfs.xfs /dev/nvme1n1
        mount /dev/nvme1n1 /app
        setenforce 0
        mkdir /app/src
        EOF
  tags =  {
    Name = "node1"
  }
}

resource "aws_instance" "node2" {
  ami           = var.instance_ami
  instance_type = var.instance_type_node
  associate_public_ip_address = true
  key_name = "mykey"
  vpc_security_group_ids = [aws_security_group.public.id]
  subnet_id = "${aws_subnet.private.id}"
  private_ip = "10.0.1.12"
  user_data = <<-EOF
        #!/bin/bash
        yum install -y net-tools vim wget epel-release
        mkdir /app
        mkfs.xfs /dev/nvme1n1
        mount /dev/nvme1n1 /app
        setenforce 0
        mkdir /app/src
        EOF
  tags =  {
    Name = "node2"
  }
}

resource "aws_instance" "node3" {
  ami           = var.instance_ami
  instance_type = var.instance_type_node
  associate_public_ip_address = true
  key_name = "mykey"
  vpc_security_group_ids = [aws_security_group.public.id]
  subnet_id = "${aws_subnet.private.id}"
  private_ip = "10.0.1.13"
  user_data = <<-EOF
        #!/bin/bash
        yum install -y net-tools vim wget epel-release
        mkdir /app
        mkfs.xfs /dev/nvme1n1
        mount /dev/nvme1n1 /app
        setenforce 0
        mkdir /app/src
        EOF
  tags =  {
    Name = "node3"
  }
}

resource "aws_instance" "node4" {
  ami           = var.instance_ami
  instance_type = var.instance_type_node
  associate_public_ip_address = true
  key_name = "mykey"
  vpc_security_group_ids = [aws_security_group.public.id]
  subnet_id = "${aws_subnet.private.id}"
  private_ip = "10.0.1.14"
  user_data = <<-EOF
        #!/bin/bash
        yum install -y net-tools vim wget epel-release
        mkdir /app
        mkfs.xfs /dev/nvme1n1
        mount /dev/nvme1n1 app
        setenforce 0
        mkdir /app/src
        EOF
  tags =  {
    Name = "node4"
  }
}

resource "aws_security_group" "public" {
  name = "terraform-example-instance"
  vpc_id = "${aws_vpc.main-vpc.id}"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

output "jumpserver_public_ip" {
value = aws_instance.jumpserver.public_ip
}

output "jumpserver_private_ip" {
value = aws_instance.jumpserver.private_ip
}

output "node1_public_ip" {
value = aws_instance.node1.public_ip
}

output "node1_private_ip" {
value = aws_instance.node1.private_ip
}

output "node2_public_ip" {
value = aws_instance.node2.public_ip
}

output "node2_private_ip" {
value = aws_instance.node2.private_ip
}

output "node3_public_ip" {
value = aws_instance.node3.public_ip
}

output "node3_private_ip" {
value = aws_instance.node3.private_ip
}

output "node4_public_ip" {
value = aws_instance.node4.public_ip
}

output "node4_private_ip" {
value = aws_instance.node4.private_ip
}
