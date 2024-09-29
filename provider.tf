# Definindo o provedor OCI
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid     # ID do tenancy (ID da conta ODI)
  user_ocid        = var.user_ocid        # ID do usuário
  private_key_path = var.private_key_path # Caminho para o arquivo de chave privada (PEM)
  fingerprint      = var.fingerprint      # A impressão digital da chave pública
  region           = var.region           # A região onde a infraestrutura será criada
}
