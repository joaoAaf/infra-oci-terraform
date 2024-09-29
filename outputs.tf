# Retorna o nome da instância da vm-01
output "name_vm-01" {
  description = "Nome da vm-01: "
  value = oci_core_instance.vm-01.display_name
}

# Retorna o IP privado da instância da vm-01
output "private-ip_vm-01" {
  description = "IP Privado: "
  value = oci_core_instance.vm-01.private_ip
}

# Retorna o IP público da instância da vm-01
output "public-ip_vm-01" {
  description = "IP Público: "
  value = oci_core_instance.vm-01.public_ip
}