angular.module('octobluApp')
.controller('NodeController', function ($scope, $state, NodeService, DeviceLogo) {
  'use strict';

  $scope.loading = true;

  NodeService.getNodes().then(function(nodes){
    nodes = _.map(nodes, addLogoUrl);
    $scope.loading = false;
    $scope.nodes = nodes;
  });

  function addLogoUrl(node){
    node.logo = new DeviceLogo(node).get();
    return node;
  }

  $scope.nextStepUrl = function (node) {
    var sref = 'material.' + node.category;
    var params = {};
    if (node.category === 'device' || node.category === 'microblu') {
      params.uuid = node.uuid;
    } else if (node.category === 'channel') {
      params.id = node.channelid;
    }
    return $state.href(sref, params);
  };

  $scope.isAvailable = function (node) {
    if (node.category === 'device' || node.category === 'microblu') {
      return node.resource.online;
    }
    return true;
  };

  $scope.filterFlows = function(node) {
    if (node.type === 'device:flow') {
      return true;
    }
    if (node.type === 'octoblu:flow') {
      return true;
    }
    return false;
  }

});
