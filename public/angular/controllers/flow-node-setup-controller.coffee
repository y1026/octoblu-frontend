class FlowNodeSetupController
  constructor: ($scope, $state, FlowService, FlowEditorService, NodeTypeService, OCTOBLU_ICON_URL) ->
    @scope             = $scope
    @state             = $state
    @FlowService       = FlowService
    @NodeTypeService   = NodeTypeService
    @FlowEditorService = FlowEditorService
    @OCTOBLU_ICON_URL  = OCTOBLU_ICON_URL

    @activeFlow = @FlowService.getActiveFlow()

  logoUrl: () =>
    return @activeFlow.selectedFlowNode.logo if @activeFlow.selectedFlowNode.logo
    return @activeFlow.selectedFlowNode.logo = "#{@OCTOBLU_ICON_URL}node/other.svg" unless @activeFlow.selectedFlowNode && @activeFlow.selectedFlowNode.type

    type = @activeFlow.selectedFlowNode.type.replace 'octoblu:', 'node:'
    type = type.replace(':', '/')
    "#{@OCTOBLU_ICON_URL}#{type}.svg"

  getNodeId: () =>
    @NodeTypeService.getNodeTypeByType(@activeFlow.selectedFlowNode.type).then (nodeType) =>
      nodeTypeId = '53c9b832f400e177dca325b3'
      nodeTypeId = nodeType._id if nodeType?._id
      @state.go 'material.nodewizard-add', nodeTypeId: nodeTypeId, designer: true

  showDelete: () =>
    @activeFlow.selectedFlowNode.needsConfiguration

  deleteNode: () =>
    newActiveFlow = @FlowEditorService.deleteSelection @activeFlow
    @activeFlow = newActiveFlow
    @FlowService.saveActiveFlow @activeFlow


angular.module('octobluApp').controller 'FlowNodeSetupController', FlowNodeSetupController