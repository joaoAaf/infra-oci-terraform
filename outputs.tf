# Outputs availability domains

output "all-availability-domains-in-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}

# Outputs compartments

output "apps-compartment-name" {
  value = oci_identity_compartment.apps-compartment.name
}

output "apps-compartment-OCID" {
  value = oci_identity_compartment.apps-compartment.id
}

output "netw-compartment-name" {
  value = oci_identity_compartment.apps-netw-compartment.name
}

output "netw-compartment-OCID" {
  value = oci_identity_compartment.apps-netw-compartment.id
}

output "vms-compartment-name" {
  value = oci_identity_compartment.apps-vms-compartment.name
}

output "vms-compartment-OCID" {
  value = oci_identity_compartment.apps-vms-compartment.id
}

# Outputs vcn module

output "vcn_id" {
  description = "OCID of the VCN that is created"
  value = module.vcn.vcn_id
}

# Outputs compute instance

output "public-ip-for-compute-instance" {
  value = oci_core_instance.apps-vm-1.public_ip
}