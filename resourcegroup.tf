resource "azurerm_resource_group" "resourcegroup" {
        name = "#{Azure.ResourceGroup.Name}"
        location = "#{Azure.Location.Name}"
        tags = {
            project = "#{Octopus.Project.Name}"
            space = "#{Octopus.Space.Name}"
            serverowner = "#{Octopus.Deployment.CreatedBy.Username}"
        }
}