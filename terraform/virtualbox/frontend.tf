resource "virtualbox_vm" "frontend" {
  count     = 1
  name      = format("frontend-node-%02d", count.index + 1)
  image     = "https://app.vagrantup.com/ubuntu/boxes/jammy64/versions/20240912.0.0/providers/virtualbox/unknown/vagrant.box"
  cpus      = 3
  memory    = "2048 mib"

  optical_disks = ["C:\\repos\\class_schedule\\terraform\\virtualbox\\frontend_cloudinit.iso"]

  network_adapter {
    type           = "bridged"
    host_interface = "Intel(R) Wi-Fi 6 AX201 160MHz"
  }
}