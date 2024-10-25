# # Retorna o nome da instância da vm-00
# output "name_vm-00" {
#   value = oci_core_instance.vm-00.display_name
# }

# # Retorna o IP privado da instância da vm-01
# output "private-ip_vm-00" {
#   value = oci_core_instance.vm-00.private_ip
# }

# # Retorna o IP público da instância da vm-01
# output "public-ip_vm-00" {
#   value = oci_core_instance.vm-00.public_ip
# }

# Retorna o nome da instância da vm-01
output "name_vm-01" {
  value = oci_core_instance.vm-01.display_name
}

# Retorna o IP privado da instância da vm-01
output "private-ip_vm-01" {
  value = oci_core_instance.vm-01.private_ip
}