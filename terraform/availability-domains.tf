# Define uma fonte de dados para obter os dominios de disponibilidade
# Um domínio de disponibilidade é um ou mais data centers localizados em uma região
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}
