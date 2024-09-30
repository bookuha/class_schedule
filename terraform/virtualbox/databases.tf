resource "virtualbox_vm" "databases" {
  count     = 1
  name      = format("databases-node-%02d", count.index + 1)
  image     = "https://app.vagrantup.com/ubuntu/boxes/jammy64/versions/20240912.0.0/providers/virtualbox/unknown/vagrant.box"
  cpus      = 2
  memory    = "1024 mib"

  optical_disks = ["C:\\repos\\class_schedule\\terraform\\virtualbox\\databases_cloudinit.iso"]

  network_adapter {
    type           = "bridged"
    host_interface = "Intel(R) Wi-Fi 6 AX201 160MHz"
  }
}