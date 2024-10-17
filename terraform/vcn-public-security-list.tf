# Define a lista de segurança para a subnet pública
resource "oci_core_security_list" "public-security-list" {

  # Dados obrigatórios para a criação da lista de segurança

  compartment_id = oci_identity_compartment.apps-netw-compartment.id # ID do compartimento onde a lista de segurança será criada
  vcn_id         = module.vcn.vcn_id                                 # Define o ID do VCN onde a lista de segurança será aplicada

  # Dados opcionais para a lista de segurança

  display_name = "public-security-list" # Nome visível para a lista de segurança
  # Regras para o trafego de saída
  egress_security_rules {
    stateless        = false        # Refere-se ao monitoramento de estado de tráfego, true desabilita o monitoramento
    destination      = "0.0.0.0/0"  # Permite acesso a qualquer endereço IP
    destination_type = "CIDR_BLOCK" # Tipo de destino, CIDR_BLOCK é a faixa IP autorizada para saída
    protocol         = "all"        # Permite tráfego de todos os protocolos
  }
  # Regras para o tráfego de entrada
  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    # ICMP protocol 1: https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml
    protocol = "1"
    # ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
    icmp_options {
      type = 3 # Define o tipo de mensagem ICMP permitida (destination Unreachable)
      code = 4 # Define o código de mensagem ICMP permitido (Fragmentation Needed and Don't Fragment was set)
    }
  }
  ingress_security_rules {
    stateless   = false
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    # ICMP protocol 1: https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml
    protocol = "1" # Apenas tráfego ICMP
    # ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
    icmp_options {
      type = 3 # Define o tipo de mensagem ICMP permitida (destination Unreachable)
    }
  }
}
