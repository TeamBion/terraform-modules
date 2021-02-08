output "client_key" {
    value = tls_private_key.root.private_key_pem
}

output "client_cert" {
    value = tls_locally_signed_cert.root.cert_pem
}