variable "tenancy_ocid" {
  description = "OCID da tenancy"
  sensitive   = true
}
variable "region" {
  description = "Região onde será criado os recursos"
}
variable "tailscale_key1" {
  description = "Auth key do Tailscale"
  sensitive   = true
}
variable "tailscale_key2" {
  description = "Auth key do Tailscale"
  sensitive   = true
}
variable "ssh_pub_key1" {
  description = "Chave Pública SSH"
  sensitive   = true
}
variable "ssh_pub_key2" {
  description = "Chave Pública SSH"
  default = ""
  sensitive   = true
}
variable "vcn_name" {
  description = "Nome da VCN"
  default     = "vcn-01"
}
variable "vcn_dns_label" {
  description = "DNS label da VCN"
  default     = "vcndns"
}
variable "vm-00_name" {
  description = "Nome da vm-00"
  default     = "vm-00"
}
variable "vm-01_name" {
  description = "Nome da vm-01"
  default     = "vm-01"
}
variable "timezone" {
  description = "Fuso Horário"
  default = "Etc/UTC"
}
variable "webdav_username" {
  description = "Usuario servidor WebDav"
  default = "username"
  sensitive = true
}
variable "webdav_password" {
  description = "Usuario servidor WebDav"
  default = "changeme"
  sensitive = true
}