output "resource_group_name" {
  description = "resource group name"
  value       = azurerm_resource_group.resource_group.name
}

output "web_app_name" {
  description = "Web app name"
  value       = azurerm_linux_web_app.app.name
}

output "web_app_url" {
  description = "Web app URL"
  value       = "https://${azurerm_linux_web_app.app.default_hostname}"
}
