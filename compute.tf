data "template_file" "cloud-init" {
  template = file("./scripts/cloud-init.yaml")
  vars = {
    tailscale_key = var.tailscale_key
  }
}

resource "oci_core_instance" "apps-vm-1" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.apps-vms-compartment.id
  shape               = "VM.Standard.A1.Flex"
  shape_config {
    ocpus         = 1
    memory_in_gbs = 3
  }
  source_details {
    source_id   = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaeor33zqzryd3smqgyg2arr4whsuobbtlwzxazovoto5vjnckaacq"
    source_type = "image"
  }
  # Optional
  display_name = "apps-vm-1"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.vcn-public-subnet.id
  }
  metadata = {
    ssh_authorized_keys = file("./private/ssh_authorized_keys")
    user_data           = base64encode(data.template_file.cloud-init.rendered)
  }
  preserve_boot_volume = false
}
