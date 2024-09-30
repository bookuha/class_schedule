output "Backend_IP_Address_1" {
  value = element(virtualbox_vm.backend.*.network_adapter.0.ipv4_address, 1)
}

output "Backend_IP_Address_2" {
  value = element(virtualbox_vm.backend.*.network_adapter.0.ipv4_address, 2)
}