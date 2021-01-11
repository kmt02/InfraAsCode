output "webapp_url" {
    value = azurerm_app_service.ngankam.default_site_hostname
}

output "webapp_ips" {
    value = azurerm_app_service.ngankam.outbound_ip_addresses
}