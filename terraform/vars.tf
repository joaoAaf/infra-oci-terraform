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