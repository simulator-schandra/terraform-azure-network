module "rg" {
    source = "./module/resource_group"
    rg_name = "simulator-rg"
    rg_location = "South India"
    tags = {
      "Environment" = "Staging"
    }
}