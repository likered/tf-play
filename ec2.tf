provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "ec2-create-users" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id     = "${var.subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.ec2-create-users.id}"]
  key_name      = "${var.key_pair_name}"

  associate_public_ip_address = true

  tags {
    Name = "${var.instance_name}"
  }
}
 
resource "aws_security_group" "ec2-create-users" {
  name   = "${var.instance_name}"
  vpc_id = "${var.vpc_id}" 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.ssh_port}"
    to_port   = "${var.ssh_port}"
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "null_resource" "everything_provisioner" {
  triggers {
    public_ip  = "${aws_instance.ec2-create-users.public_ip}"
    private_ip = "${aws_instance.ec2-create-users.private_ip}"
  }

  connection {
    type = "ssh"
    host = "${aws_instance.ec2-create-users.public_ip}"
    user = "${var.ssh_user}"
    port = "${var.ssh_port}"
    agent = false
  }
 
  provisioner "file" {
    source      = "files/example-file.txt"
    destination = "/tmp/example-file.txt"
  }

  provisioner "remote-exec" {
    inline = [ 
      "echo 'this-is-2-now' >> /tmp/example-file.txt",
      "cat /tmp/example-file.txt",
      "echo /tmp/example-file.txt > /tmp/new-example-file.txt"
    ]   
  }

  provisioner "local-exec" {
    command = "scp -i /root/.ssh/terraform.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.ssh_user}@${aws_instance.ec2-create-users.public_ip}:/tmp/new-example-file.txt new-example-file.txt"
  }
}
