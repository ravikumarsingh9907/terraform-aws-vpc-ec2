resource "aws_instance" "learn-easy-apk" {
  ami = data.aws_ami.ami-config.id
  instance_type  = "t2.micro"
  
  subnet_id = values(var.public_subnet_ids)[0]
  key_name = aws_key_pair.learn-easy-key-pair.key_name
  security_groups = [ var.security_group ]

  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    delete_on_termination = true
  }

  tags = {
    Name = "learn-easy-apk"
  }
}