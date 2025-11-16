resource "azurerm_resource_group" "resource_group" {
  name     = "${var.prefix_app_name}-${random_string.suffix.result}-RG"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_service_plan" "asp" {
  name                = "${var.prefix_app_name}-${random_string.suffix.result}-asp"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  sku_name            = "S1"
  os_type             = "Linux"
  tags                = local.common_tags
}

resource "azurerm_linux_web_app" "app" {
  name                = "${var.prefix_app_name}-${random_string.suffix.result}-app"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = true

    application_stack {
      docker_image_name = "${var.docker_repo}${var.docker_tag}"
      docker_registry_url = var.docker_url
    }
  }
  app_settings = {
    "WEBSITES_PORT" = "5000"
  }
}

