output "public_instance_id" {
  value = "${aws_instance.ec2-create-users.id}"
}

output "public_instance_ip" {
  value = "${aws_instance.ec2-create-users.public_ip}"
}
