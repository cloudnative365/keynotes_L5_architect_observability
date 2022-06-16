resource "aws_volume_attachment" "ebs_att_node1" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.node1.id
  instance_id = aws_instance.node1.id
}

resource "aws_ebs_volume" "node1" {
  availability_zone = "ap-northeast-1a"
  size              = 100
}

resource "aws_volume_attachment" "ebs_att_node2" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.node2.id
  instance_id = aws_instance.node2.id
}

resource "aws_ebs_volume" "node2" {
  availability_zone = "ap-northeast-1a"
  size              = 100
}

resource "aws_volume_attachment" "ebs_att_node3" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.node3.id
  instance_id = aws_instance.node3.id
}

resource "aws_ebs_volume" "node3" {
  availability_zone = "ap-northeast-1a"
  size              = 100
}

resource "aws_volume_attachment" "ebs_att_node4" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.node4.id
  instance_id = aws_instance.node4.id
}

resource "aws_ebs_volume" "node4" {
  availability_zone = "ap-northeast-1a"
  size              = 100
}
