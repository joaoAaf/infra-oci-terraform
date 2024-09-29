# Define a módulo chamado "vcn" que usa o módulo Oracle Cloud Infrastructure (OCI) 
# para gerenciar uma Virtual Cloud Network (VCN).
module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci" # Especifica a fonte do módulo, que é um módulo público no Terraform Registry.
  version = "3.6.0"                            # Define a versão específica do módulo a ser usada.

  # Dados obrigatórios para o módulo vcn.

  compartment_id = oci_identity_compartment.apps-netw-compartment.id # A ID do compartimento OCI onde a VCN será criada. 

  # Dados opcionais para o módulo vcn.

  region                  = var.region        # A região OCI onde a VCN será criada.
  vcn_name                = var.vcn_name      # O nome da VCN.
  vcn_dns_label           = var.vcn_dns_label # O rótulo DNS da VCN.
  vcn_cidrs               = ["10.0.0.0/16"]   # Uma lista de CIDRs que serão usados pela VCN.
  create_internet_gateway = true              # Especifica se um gateway de internet deve ser criado.
  create_nat_gateway      = true              # Especifica se um gateway NAT deve ser criado.
  create_service_gateway  = true              # Especifica se um gateway de serviço deve ser criado.
}
