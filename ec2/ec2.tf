resource "aws_instance" "app1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  #vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0] #
  associate_public_ip_address = true
  key_name                    = "hamelek2-7304"
  vpc_security_group_ids      = [aws_security_group.app1_group.id]

  tags = {
    Name = "LFClass1"
  }
}

resource "aws_instance" "app2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  #vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0] #
  associate_public_ip_address = true
  key_name                    = "hamelek2-7304"
  vpc_security_group_ids      = [aws_security_group.app1_group.id]
  tags = {
    Name = "LFClass2"
  }
}