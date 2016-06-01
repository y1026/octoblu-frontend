angular.module('octobluApp')
.directive 'permissionV2',  ($window) ->
  {
    restrict: 'E'
    templateUrl: '/angular/directives/permission/permission-v2.html'
    controller: "PermissionV2Controller"
    controllerAs: 'controller'
    scope:
      type: '='
      list: '='
      removePermission: '='
      addPermission: '='
  }
