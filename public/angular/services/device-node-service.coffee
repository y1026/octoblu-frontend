class DeviceNodeService
  constructor: ($q, ThingService, NodeConversionService) ->
    @q = $q
    @ThingService = ThingService
    @NodeConversionService = NodeConversionService

  convertFlow: (node) =>
    return node unless node.type == 'octoblu:flow' || node.type == 'device:flow'
    defaults =
      type: 'octoblu:flow'
      topic: 'flow'
      filterTopic: 'message'

    _.extend defaults, node

  convertDevice: (node) =>
    defaults =
      category: 'device'
      useStaticMessage: true

    _.extend defaults, node

  convert: (node) =>
    @NodeConversionService.convert @convertDevice @convertFlow node

  fetch: =>
    projection =
      uuid:     true
      name:     true
      type:     true
      logo:     true
      category: true
      online:   true

    @ThingService.getThings {type: {$ne: 'octoblu:user'}}, projection
      .then (devices) =>
        promises = _.map devices, @convert
        @q.all promises

angular.module('octobluApp').service 'DeviceNodeService', DeviceNodeService