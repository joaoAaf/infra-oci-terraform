resource "oci_core_subnet" "vcn-private-subnet"{
  # Required
  compartment_id = oci_identity_compartment.apps-netw-compartment.id
  vcn_id = module.vcn.vcn_id
  cidr_block = "10.0.1.0/24"
  # Optional
  route_table_id = module.vcn.nat_route_id
  security_list_ids = [oci_core_security_list.private-security-list.id]
  display_name = "private-subnet"
}