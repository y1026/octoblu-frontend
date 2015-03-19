class FlowTutorialService
  constructor: (FlowNodeTypeService) ->
    @FlowNodeTypeService = FlowNodeTypeService

  getStepNumber: (flow) =>
    weatherNode = _.find flow.nodes, { type: 'channel:weather' }
    triggerNode = _.find flow.nodes, { type: 'operation:trigger' }
    weatherTriggerLink = _.find flow.links, { from: triggerNode?.id, to: weatherNode?.id }        
    emailNode = _.find flow.nodes, { type: 'channel:email' }
    emailLink = _.find flow.links, { from: weatherNode?.id, to: emailNode?.id }        
    
    return 0 unless weatherNode
    return 1 unless weatherNode.queryParams?.city?
    return 2 unless triggerNode
    return 3 unless weatherTriggerLink
    return 4 unless emailNode
    return 5 unless emailNode.bodyParams?.to? && emailNode.bodyParams.body == '{{msg.temperature}}' 
    return 6 unless emailLink
    return 7 unless flow.deployed
    return 8 unless flow.triggered
    return 9

  getStep: (flow) =>
    @FlowNodeTypeService.getFlowNodeTypes()
      .then (flowNodeTypes) =>
        stepNumber = @getStepNumber flow
        return flowNodeTypes: _.filter flowNodeTypes, { type: 'channel:weather'} if stepNumber == 0
        return flowNodeTypes: _.filter flowNodeTypes, { type: 'channel:trigger'} if stepNumber == 1
        return flowNodeTypes: _.filter flowNodeTypes, { type: 'channel:email'} if stepNumber   == 3
        return flowNodeTypes: flowNodeTypes


angular.module 'octobluApp'
  .service 'FlowTutorialService', FlowTutorialService
