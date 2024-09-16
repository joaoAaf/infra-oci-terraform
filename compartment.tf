resource "oci_identity_compartment" "apps-compartment" {
    compartment_id = var.tenancy_ocid
    description = "Compartimento de Aplicações"
    name = "apps"
}

resource "oci_identity_compartment" "apps-netw-compartment" {
   compartment_id = oci_identity_compartment.apps-compartment.id
   description = "Compartimento de Rede"
   name = "apps-network"
}

resource "oci_identity_compartment" "apps-vms-compartment" {
  compartment_id = oci_identity_compartment.apps-compartment.id
  description = "Compartimento de VMs"
  name = "apps-vms"
}