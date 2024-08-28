resource "aws_security_group" "sg-learn-easy" {
  name = "sg_learn_easy_apk"
  description = "security group for learn easy application"
  vpc_id = var.vpc_id

  tags = {
    Name = "sg_learn_easy_apk"
  }
}