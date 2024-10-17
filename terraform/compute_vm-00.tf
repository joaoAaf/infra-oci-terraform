# Define um arquivo de template para o Cloud-init utilizando o arquivo cloud-init.yaml
data "template_file" "cloud-init_vm-00" {
  template = file("../scripts/cloud-init_vm-00.yaml")
  # Variáveis a serem substituídas no template
  vars = {
    tailscale_key = var.tailscale_key1
  }
}

# Cria uma instância VM no OCI
resource "oci_core_instance" "vm-00" {

  # Dados obrigatórios para criação da instância

  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name # Define o domínio de disponibilidade da instância a partir dos dados da OCI
  compartment_id      = oci_identity_compartment.apps-vms-compartment.id                        # Define o compartment ID para a instância
  shape               = "VM.Standard.A1.Flex"                                                   # Define o shape da instância (modelo de máquina virtual)
  # Define as configurações de hardware da instância
  shape_config {
    ocpus         = 2  # Define o número de CPUs
    memory_in_gbs = 12 # Define a quantidade de memória em GBs
  }
  # Detalhes da imagem a ser utilizada para criar a instância
  source_details {
    source_id               = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaeor33zqzryd3smqgyg2arr4whsuobbtlwzxazovoto5vjnckaacq" # Define o ID da imagem a ser utilizada para criar a instância
    source_type             = "image"                                                                                      # Define o tipo de fonte como imagem
    boot_volume_size_in_gbs = 70                                                                                           # Define o tamanho do disco rígido da instância em GBs
  }

  # Dados opcionais para personalização da instância

  display_name = var.vm-00_name # Define o nome da instância
  # Dados para a criação da interface de rede da instância
  create_vnic_details {
    assign_public_ip = true                                 # Atribui um IP público à instância
    subnet_id        = oci_core_subnet.vcn-public-subnet.id # Define a subnet ID para a instância
  }
  # Dados passados para a instância após sua criação
  metadata = {
    ssh_authorized_keys = file("../private/ssh_authorized_keys")                     # Define as chaves SSH autorizadas para acesso à instância
    user_data           = base64encode(data.template_file.cloud-init_vm-00.rendered) # Define o conteúdo do arquivo cloud-init codificado em Base64
  }
  preserve_boot_volume = false # Define se o volume de inicialização deve ser preservado
}
