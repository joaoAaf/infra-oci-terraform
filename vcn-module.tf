module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.6.0"
  # insert the 1 required variable here
  # Required Inputs
  compartment_id = oci_identity_compartment.apps-netw-compartment.id
  # Optional Inputs
  region = var.region
  vcn_name = "vcn-apps"
  vcn_dns_label = "apps"
  vcn_cidrs = ["10.0.0.0/16"]
  create_internet_gateway = true
  create_nat_gateway = true
  create_service_gateway = true
}