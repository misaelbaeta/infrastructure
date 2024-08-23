output "app1_id" {
  value = aws_instance.app1.id
}

output "app2_id" {
  value = aws_instance.app2.id
}

#output "instance_private_ip" {
#  value = aws_instance.app1.instance_private_ip
#}
#
#output "instance_private_ip" {
#  value = aws_instance.app2.instance_private_ip
#}


output "all_instance_ids" {
  value = {
    app1 = aws_instance.app1.id
    app2 = aws_instance.app2.id
  }
  description = "A map of all EC2 instance IDs."
}

output "all_instance_private_ips" {
  value = {
    app1 = aws_instance.app1.private_ip
    app2 = aws_instance.app2.private_ip
  }
  description = "A map of all EC2 instance private IPs."
}

output "all_instance_public_ips" {
  value = {
    app1 = aws_instance.app1.public_ip
    app2 = aws_instance.app2.public_ip
  }
  description = "A map of all EC2 instance public IPs."
}
