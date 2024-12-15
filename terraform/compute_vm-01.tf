# Define um arquivo de template para o Cloud-init utilizando o arquivo cloud-init.yaml
data "template_file" "cloud-init_vm-01" {
  template = file("../scripts/cloud-init_vm-01.yaml")
  # Variáveis a serem substituídas no template
  vars = {
    tailscale_key = var.tailscale_key2
    ssh_pub_key1  = var.ssh_pub_key1
    ssh_pub_key2  = var.ssh_pub_key2
    timezone = var.timezone
    webdav_username = var.webdav_username
    webdav_password = var.webdav_password
    pg_pass = var.pg_pass
    docker_compose_content = base64encode(file("../scripts/docker-compose_vm-01.yml"))
  }
}

# Cria uma instância VM no OCI
resource "oci_core_instance" "vm-01" {

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
    boot_volume_size_in_gbs = 130                                                                                          # Define o tamanho do disco rígido da instância em GBs
  }

  # Dados opcionais para personalização da instância

  display_name = var.vm-01_name # Define o nome da instância
  # Dados para a criação da interface de rede da instância
  create_vnic_details {
    assign_public_ip = false                                 # Atribui um IP público à instância
    subnet_id        = oci_core_subnet.vcn-private-subnet.id # Define a subnet ID para a instância
  }
  # Dados passados para a instância após sua criação
  metadata = {
    user_data = base64encode(data.template_file.cloud-init_vm-01.rendered) # Define o conteúdo do arquivo cloud-init codificado em Base64
  }
  preserve_boot_volume = false # Define se o volume de inicialização deve ser preservado
}
