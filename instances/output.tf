output "private-key-pair" {
  value = tls_private_key.learn-easy-pk.private_key_pem
  sensitive = true
}