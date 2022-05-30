output "external_ip_address_clickhouse-01_yandex_cloud" {
  value = "${yandex_compute_instance.clickhouse-01.network_interface.0.nat_ip_address}"
}

output "external_ip_address_vector-01_yandex_cloud" {
  value = "${yandex_compute_instance.vector-01.network_interface.0.nat_ip_address}"
}

output "external_ip_address_lighthouse-01_yandex_cloud" {
  value = "${yandex_compute_instance.lighthouse-01.network_interface.0.nat_ip_address}"
}