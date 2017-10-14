provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "ejabberdnode" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  key_name      = "YOUR_AWS_KEYNAME"
  count         = "${var.instance_count}"
  security_groups = ["allow_traffic"]
  tags {
    Name = "ejabberd-${count.index}"
  }
}

resource "aws_security_group" "allow_traffic" {
   name        = "allow_traffic"
   description = "Allow portwise inbound traffic"

   ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     from_port       = 0
     to_port         = 0
     protocol        = "-1"
     cidr_blocks     = ["0.0.0.0/0"]
   }
 }

data "template_file" "server_config" {
  template = "${file("new_terra_setup.sh")}"
}

data "template_file" "cluster" {
  template = "${file("cluster_setup.sh")}"
}

resource "null_resource" "install" {
  # Install provisioning

  count         = "${var.instance_count}"

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("~/.ssh/YOUR.PEM")}"
    host        = "${element(aws_instance.ejabberdnode.*.public_ip, count.index)}"
  }

  provisioner "file" {
    source     = "new_terra_setup.sh"
    destination = "~/new_terra_setup.sh"
  }

  provisioner "remote-exec" {
  inline = [
    "chmod +x ~/new_terra_setup.sh",
    "echo 'chmod done'",
    "sudo ~/new_terra_setup.sh ${var.admin_ejabberd} ${var.pass_ejabberd} ${var.erlang_cookie} ${element(aws_instance.ejabberdnode.*.private_ip, count.index)} ${aws_instance.ejabberdnode.0.private_ip} ${var.ejabberddomain}",
    "echo 'run done'",
  ]
  }
}

resource "null_resource" "join" {
  # Cluster join provisioning

  count         = "${var.instance_count}"
  depends_on = ["null_resource.install"]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("~/.ssh/YOUR.PEM")}"
    host        = "${element(aws_instance.ejabberdnode.*.public_ip, count.index)}"
  }

  provisioner "file" {
    source     = "cluster_setup.sh"
    destination = "~/cluster_setup.sh"
  }

  provisioner "remote-exec" {
  inline = [
    "chmod +x ~/cluster_setup.sh",
    "sudo ~/cluster_setup.sh ${aws_instance.ejabberdnode.0.private_ip} ${element(aws_instance.ejabberdnode.*.private_ip, count.index)}",
    "echo 'run done'",
  ]
  }
}
