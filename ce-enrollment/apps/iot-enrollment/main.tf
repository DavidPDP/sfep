resource "azurerm_resource_group" "dev_resource_group" {
  name     = "dev-safefleetiot-gov-rg"
  location = "eastus"
}

resource "azurerm_service_plan" "dev_service_plan" {
  name                = "dev-azfunctionsp-gov-service-plan"
  resource_group_name = azurerm_resource_group.dev_resource_group.name
  location            = azurerm_resource_group.dev_resource_group.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_storage_account" "dev_storage_account" {
  name                     = "devstorageaccount2"
  resource_group_name      = azurerm_resource_group.dev_resource_group.name
  location                 = azurerm_resource_group.dev_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "terraform_data" "iot_enrollment_asset_sha" {
  input = filesha256("${path.module}/iot-device-enrollment-function-linux-x64.zip")
}

resource "azurerm_linux_function_app" "iot_enrollment_function_app" {
  name                = "dev-iot-enrollment-function-app-test"
  resource_group_name = azurerm_resource_group.dev_resource_group.name
  location            = azurerm_resource_group.dev_resource_group.location

  storage_account_name        = azurerm_storage_account.dev_storage_account.name
  storage_account_access_key  = azurerm_storage_account.dev_storage_account.primary_access_key
  service_plan_id             = azurerm_service_plan.dev_service_plan.id

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE=1
  }

  functions_extension_version = "~4"
  zip_deploy_file             = "${path.module}/iot-device-enrollment-function-linux-x64.zip"

  site_config {
    application_stack {
      dotnet_version = "8.0"
      use_dotnet_isolated_runtime = true
    }
  }

  lifecycle {
    replace_triggered_by = [terraform_data.iot_enrollment_asset_sha]
  }
}
