# Define um compartimento chamado "apps" no tenancy especificado. 
resource "oci_identity_compartment" "apps-compartment" {
  compartment_id = var.tenancy_ocid # Pai é o tenancy
  description    = "Compartimento de Aplicações"
  name           = "apps"
}

# Define um compartimento chamado "apps-network" dentro do compartimento "apps". 
resource "oci_identity_compartment" "apps-netw-compartment" {
  compartment_id = oci_identity_compartment.apps-compartment.id # Pai é o compartimento "apps"
  description    = "Compartimento de Rede"
  name           = "apps-network"
}

# Define um compartimento chamado "apps-vms" dentro do compartimento "apps". 
resource "oci_identity_compartment" "apps-vms-compartment" {
  compartment_id = oci_identity_compartment.apps-compartment.id # Pai é o compartimento "apps"
  description    = "Compartimento de VMs"
  name           = "apps-vms"
}
