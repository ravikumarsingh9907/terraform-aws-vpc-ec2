resource "tls_private_key" "learn-easy-pk" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "learn-easy-key-pair" {
  key_name = "learn-easy-key-pair"
  public_key = tls_private_key.learn-easy-pk.public_key_openssh
}