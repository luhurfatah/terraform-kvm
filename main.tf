provider "libvirt" {
  uri = "qemu:///system"
}

terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

# controller
data "template_file" "controller_user_data" {
  template = file("${path.module}/user_data/controller.cfg")
}

data "template_file" "controller_network_config" {
  template = file("${path.module}/network/controller-network.cfg")
}

resource "libvirt_cloudinit_disk" "controller-cloudinit" {
  name           = "controller-cloudinit.iso"
  pool           = "vms"
  user_data      = data.template_file.controller_user_data.rendered
  network_config = data.template_file.controller_network_config.rendered
}

resource "libvirt_volume" "controller-vda" {
  name             = "controller-vda.qcow2"
  pool             = "vms"
  base_volume_name = "ubuntu-jammy.img"
  base_volume_pool = "isos"
  size             = "53687091200"
  format           = "qcow2"
}

resource "libvirt_domain" "controller" {
  name    = "controller"
  memory  = "4096"
  vcpu    = "2"
  machine = "pc-i440fx-rhel7.6.0"

  cpu {
    mode = "host-passthrough"
  }

  cloudinit = libvirt_cloudinit_disk.controller-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }

  network_interface {
    network_name = "net-10.10.10"
    addresses    = ["10.10.10.10"]
  }

  network_interface {
    network_name = "net-10.10.20"
    addresses    = ["10.10.20.10"]
  }

  network_interface {
    network_name = "net-10.10.30"
    addresses    = ["10.10.30.10"]
  }

  disk {
    volume_id = libvirt_volume.controller-vda.id
  }

  video {
    type = "vga"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

# openstack-node1
data "template_file" "openstack1_user_data" {
  template = file("${path.module}/user_data/openstack1.cfg")
}

data "template_file" "openstack1_network_config" {
  template = file("${path.module}/network/openstack1-network.cfg")
}

resource "libvirt_cloudinit_disk" "openstack1-cloudinit" {
  name           = "openstack1-cloudinit.iso"
  pool           = "vms"
  user_data      = data.template_file.openstack1_user_data.rendered
  network_config = data.template_file.openstack1_network_config.rendered
}

resource "libvirt_volume" "openstack1-vda" {
  name             = "openstack1-vda.qcow2"
  pool             = "vms"
  base_volume_name = "ubuntu-jammy.img"
  base_volume_pool = "isos"
  size             = "53687091200"
  format           = "qcow2"
}

resource "libvirt_domain" "openstack1" {
  name    = "openstack1"
  memory  = "8192"
  vcpu    = "4"
  machine = "pc-i440fx-rhel7.6.0"

  cpu {
    mode = "host-passthrough"
  }

  cloudinit = libvirt_cloudinit_disk.openstack1-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }

  network_interface {
    network_name = "net-10.10.10"
    addresses    = ["10.10.10.20"]
  }

  network_interface {
    network_name = "net-10.10.20"
    addresses    = ["10.10.20.20"]
  }

  network_interface {
    network_name = "net-10.10.30"
    addresses    = ["10.10.30.20"]
  }

  disk {
    volume_id = libvirt_volume.openstack1-vda.id
  }

  video {
    type = "vga"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

# openstack-node2
data "template_file" "openstack2_user_data" {
  template = file("${path.module}/user_data/openstack2.cfg")
}

data "template_file" "openstack2_network_config" {
  template = file("${path.module}/network/openstack2-network.cfg")
}

resource "libvirt_cloudinit_disk" "openstack2-cloudinit" {
  name           = "openstack2-cloudinit.iso"
  pool           = "vms"
  user_data      = data.template_file.openstack2_user_data.rendered
  network_config = data.template_file.openstack2_network_config.rendered
}

resource "libvirt_volume" "openstack2-vda" {
  name             = "openstack2-vda.qcow2"
  pool             = "vms"
  base_volume_name = "ubuntu-jammy.img"
  base_volume_pool = "isos"
  size             = "53687091200"
  format           = "qcow2"
}

resource "libvirt_domain" "openstack2" {
  name    = "openstack2"
  memory  = "8192"
  vcpu    = "4"
  machine = "pc-i440fx-rhel7.6.0"

  cpu {
    mode = "host-passthrough"
  }

  cloudinit = libvirt_cloudinit_disk.openstack2-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }

  network_interface {
    network_name = "net-10.10.10"
    addresses    = ["10.10.10.21"]
  }

  network_interface {
    network_name = "net-10.10.20"
    addresses    = ["10.10.20.21"]
  }

  network_interface {
    network_name = "net-10.10.30"
    addresses    = ["10.10.30.21"]
  }

  disk {
    volume_id = libvirt_volume.openstack2-vda.id
  }

  video {
    type = "vga"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

# ceph-node1
data "template_file" "ceph1_user_data" {
  template = file("${path.module}/user_data/ceph1.cfg")
}

data "template_file" "ceph1_network_config" {
  template = file("${path.module}/network/ceph1-network.cfg")
}

resource "libvirt_cloudinit_disk" "ceph1-cloudinit" {
  name           = "ceph1-cloudinit.iso"
  pool           = "vms"
  user_data      = data.template_file.ceph1_user_data.rendered
  network_config = data.template_file.ceph1_network_config.rendered
}

resource "libvirt_volume" "ceph1-vda" {
  name             = "ceph1-vda.qcow2"
  pool             = "vms"
  base_volume_name = "ubuntu-jammy.img"
  base_volume_pool = "isos"
  size             = "53687091200"
  format           = "qcow2"
}

resource "libvirt_volume" "ceph1-vdb" {
  name   = "ceph1-vdb.qcow2"
  pool   = "vms"
  size   = "53687091200"
  format = "qcow2"
}

resource "libvirt_volume" "ceph1-vdc" {
  name   = "ceph1-vdc.qcow2"
  pool   = "vms"
  size   = "53687091200"
  format = "qcow2"
}


resource "libvirt_domain" "ceph1" {
  name    = "ceph1"
  memory  = "4096"
  vcpu    = "2"
  machine = "pc-i440fx-rhel7.6.0"

  cpu {
    mode = "host-passthrough"
  }

  cloudinit = libvirt_cloudinit_disk.ceph1-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }

  network_interface {
    network_name = "net-10.10.10"
    addresses    = ["10.10.10.30"]
  }

  network_interface {
    network_name = "net-10.10.20"
    addresses    = ["10.10.20.30"]
  }

  disk {
    volume_id = libvirt_volume.ceph1-vda.id
  }

  disk {
    volume_id = libvirt_volume.ceph1-vdb.id
  }

  disk {
    volume_id = libvirt_volume.ceph1-vdc.id
  }

  video {
    type = "vga"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

# ceph-node2
data "template_file" "ceph2_user_data" {
  template = file("${path.module}/user_data/ceph2.cfg")
}

data "template_file" "ceph2_network_config" {
  template = file("${path.module}/network/ceph2-network.cfg")
}

resource "libvirt_cloudinit_disk" "ceph2-cloudinit" {
  name           = "ceph2-cloudinit.iso"
  pool           = "vms"
  user_data      = data.template_file.ceph2_user_data.rendered
  network_config = data.template_file.ceph2_network_config.rendered
}

resource "libvirt_volume" "ceph2-vda" {
  name             = "ceph2-vda.qcow2"
  pool             = "vms"
  base_volume_name = "ubuntu-jammy.img"
  base_volume_pool = "isos"
  size             = "53687091200"
  format           = "qcow2"
}

resource "libvirt_volume" "ceph2-vdb" {
  name   = "ceph2-vdb.qcow2"
  pool   = "vms"
  size   = "53687091200"
  format = "qcow2"
}

resource "libvirt_volume" "ceph2-vdc" {
  name   = "ceph2-vdc.qcow2"
  pool   = "vms"
  size   = "53687091200"
  format = "qcow2"
}


resource "libvirt_domain" "ceph2" {
  name    = "ceph2"
  memory  = "4096"
  vcpu    = "2"
  machine = "pc-i440fx-rhel7.6.0"

  cpu {
    mode = "host-passthrough"
  }

  cloudinit = libvirt_cloudinit_disk.ceph2-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }

  network_interface {
    network_name = "net-10.10.10"
    addresses    = ["10.10.10.31"]
  }

  network_interface {
    network_name = "net-10.10.20"
    addresses    = ["10.10.20.31"]
  }

  disk {
    volume_id = libvirt_volume.ceph2-vda.id
  }

  disk {
    volume_id = libvirt_volume.ceph2-vdb.id
  }

  disk {
    volume_id = libvirt_volume.ceph2-vdc.id
  }

  video {
    type = "vga"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

# gluster-node1
data "template_file" "gluster1_user_data" {
  template = file("${path.module}/user_data/gluster1.cfg")
}

data "template_file" "gluster1_network_config" {
  template = file("${path.module}/network/gluster1-network.cfg")
}

resource "libvirt_cloudinit_disk" "gluster1-cloudinit" {
  name           = "gluster1-cloudinit.iso"
  pool           = "vms"
  user_data      = data.template_file.gluster1_user_data.rendered
  network_config = data.template_file.gluster1_network_config.rendered
}

resource "libvirt_volume" "gluster1-vda" {
  name             = "gluster1-vda.qcow2"
  pool             = "vms"
  base_volume_name = "ubuntu-jammy.img"
  base_volume_pool = "isos"
  size             = "53687091200"
  format           = "qcow2"
}

resource "libvirt_volume" "gluster1-vdb" {
  name   = "gluster1-vdb.qcow2"
  pool   = "vms"
  size   = "53687091200"
  format = "qcow2"
}

resource "libvirt_volume" "gluster1-vdc" {
  name   = "gluster1-vdc.qcow2"
  pool   = "vms"
  size   = "53687091200"
  format = "qcow2"
}


resource "libvirt_domain" "gluster1" {
  name    = "gluster1"
  memory  = "4096"
  vcpu    = "2"
  machine = "pc-i440fx-rhel7.6.0"

  cpu {
    mode = "host-passthrough"
  }

  cloudinit = libvirt_cloudinit_disk.gluster1-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }

  network_interface {
    network_name = "net-10.10.10"
    addresses    = ["10.10.10.40"]
  }

  network_interface {
    network_name = "net-10.10.30"
    addresses    = ["10.10.30.40"]
  }

  disk {
    volume_id = libvirt_volume.gluster1-vda.id
  }

  disk {
    volume_id = libvirt_volume.gluster1-vdb.id
  }

  disk {
    volume_id = libvirt_volume.gluster1-vdc.id
  }

  video {
    type = "vga"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

# gluster-node2
data "template_file" "gluster2_user_data" {
  template = file("${path.module}/user_data/gluster2.cfg")
}

data "template_file" "gluster2_network_config" {
  template = file("${path.module}/network/gluster2-network.cfg")
}

resource "libvirt_cloudinit_disk" "gluster2-cloudinit" {
  name           = "gluster2-cloudinit.iso"
  pool           = "vms"
  user_data      = data.template_file.gluster2_user_data.rendered
  network_config = data.template_file.gluster2_network_config.rendered
}

resource "libvirt_volume" "gluster2-vda" {
  name             = "gluster2-vda.qcow2"
  pool             = "vms"
  base_volume_name = "ubuntu-jammy.img"
  base_volume_pool = "isos"
  size             = "53687091200"
  format           = "qcow2"
}

resource "libvirt_volume" "gluster2-vdb" {
  name   = "gluster2-vdb.qcow2"
  pool   = "vms"
  size   = "53687091200"
  format = "qcow2"
}

resource "libvirt_volume" "gluster2-vdc" {
  name   = "gluster2-vdc.qcow2"
  pool   = "vms"
  size   = "53687091200"
  format = "qcow2"
}


resource "libvirt_domain" "gluster2" {
  name    = "gluster2"
  memory  = "4096"
  vcpu    = "2"
  machine = "pc-i440fx-rhel7.6.0"

  cpu {
    mode = "host-passthrough"
  }

  cloudinit = libvirt_cloudinit_disk.gluster2-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }

  network_interface {
    network_name = "net-10.10.10"
    addresses    = ["10.10.10.41"]
  }

  network_interface {
    network_name = "net-10.10.30"
    addresses    = ["10.10.30.41"]
  }

  disk {
    volume_id = libvirt_volume.gluster2-vda.id
  }

  disk {
    volume_id = libvirt_volume.gluster2-vdb.id
  }

  disk {
    volume_id = libvirt_volume.gluster2-vdc.id
  }

  video {
    type = "vga"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

