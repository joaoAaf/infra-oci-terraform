# Define uma subnet privada
resource "oci_core_subnet" "vcn-private-subnet" {

  # Dados obrigatórios para a criação de uma subnet

  compartment_id = oci_identity_compartment.apps-netw-compartment.id # O ID do compartimento onde a subnet será criada.
  vcn_id         = module.vcn.vcn_id                                 # O ID da VCN que a subnet pertencerá.
  cidr_block     = "10.0.1.0/24"                                     # O bloco de endereços IP da subnet.

  # Dados opcionais para uma subnet

  route_table_id    = module.vcn.nat_route_id                           # Define a tabela de roteamento que será usada pela subnet.
  security_list_ids = [oci_core_security_list.private-security-list.id] # Define as listas de segurança que serão aplicadas à subnet.
  display_name      = "private-subnet"                                  # Define o nome exibido para a subnet.
}
