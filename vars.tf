variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "private_key_path" {}
variable "ssh_pub_key_path_local" {}
variable "ssh_pub_key_path_cloudshell" {}
variable "fingerprint" {}
variable "region" {}
variable "tailscale_key" {
  sensitive = true
}
