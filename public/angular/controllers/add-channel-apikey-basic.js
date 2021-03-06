'use strict';

angular.module('octobluApp')
.controller('addChannelApiKeyBasicController', function($scope, $state, $stateParams, nodeType, userService, AuthService) {
  $scope.activate = function(){
    AuthService.getCurrentUser().then(function(user){
      userService.saveBasicApi(user.resource.uuid, nodeType.channelid, $scope.newChannel.apiKey, '', function () {
        var redirectToDesign = $stateParams.designer || false;
        var redirectToWizard = $stateParams.wizard || false;
        var route = 'material.things.my';
        var params = {added: nodeType.name};
        if(redirectToWizard){
          route = 'material.flowConfigure';
          params = {flowId: $stateParams.wizardFlowId, nodeIndex: $stateParams.wizardNodeIndex};
        }
        if(redirectToDesign){
          route = 'material.design';
        }
        $state.go(route, params);
      });
    });
  };
});
