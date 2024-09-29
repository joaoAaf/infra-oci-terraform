variable "vcn_name" {
  description = "Nome da VCN"
  default     = "vcn-01"
}

variable "vcn_dns_label" {
  description = "DNS label da VCN"
  default     = "vcn-dns-01"
}

variable "tenancy_ocid" {
  description = "OCID da tenancy"
  sensitive   = true
}

variable "vm-01_name" {
  description = "Nome da vm-01"
  default     = "vm-01"
}

variable "user_ocid" {
  description = "OCID do usuário"
  sensitive   = true
}
variable "private_key_path" {
  description = "Caminho para a chave privada do usuário"
  sensitive   = true
}
variable "fingerprint" {
  description = "Fingerprint da chave pública do usuário"
  sensitive   = true
}
variable "region" {
  description = "Região onde será criado os recursos"
}
variable "tailscale_key" {
  description = "Auth key do Tailscale"
  sensitive   = true
}
