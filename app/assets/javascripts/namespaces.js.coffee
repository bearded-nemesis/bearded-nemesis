#angular.module("Beard.Ratings", ['ngResource'])
#window.BeardNgServices = angular.module("Beard.Services", ["ngResource"])
#window.BeardNgControllers = angular.module("Beard.Controllers", ["Beard.Services"])
#window.BeardNg = angular.module("Beard", ["Beard.Controllers", "Beard.Services"])

#angular.module("Beard.Controllers", [])
#angular.module("Beard.Services", [])

window.beard = {
  services: angular.module "beard.services", ["ngResource"]
  controllers: angular.module "beard.controllers", ["beard.services"]
}

angular.module("beard", ['beard.services', 'beard.controllers'])

window.Beard =
  Widgets: {}
  Models: {}
  Controllers: {}
  #App: angular.module("Beard", ["Beard.Controllers", "Beard.Services"])

Beard.Widgets.Songs = {}
Beard.Models.Songs = {}