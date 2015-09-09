angular.module("octobluApp").factory "GatebluLogService",
(skynetService, GATEBLU_LOGGER_UUID, $cookies, UUIDService) ->
  class GatebluLogService
    constructor: () ->
      @deploymentUuid = UUIDService.v1()
      @userUuid       = $cookies.meshblu_auth_uuid
      @APPLICATION    = "app-octoblu"
      @WORKFLOW       = 'device-add-to-gateblu'

    addDeviceBegin: (gatebluUuid, nodeType) =>
      @logEvent "begin", gatebluUuid, null, nodeType.connector

    registerDeviceBegin: (gatebluUuid, connector) =>
      @logEvent "register-device-begin", null, gatebluUuid, connector

    registerDeviceEnd: (deviceUuid, gatebluUuid, connector) =>
      @logEvent "register-device-end", deviceUuid, gatebluUuid, connector

    updateGatebluBegin: (deviceUuid, gatebluUuid, connector) =>
      @logEvent "gateblu-update-begin", deviceUuid, gatebluUuid, connector

    updateGatebluEnd: (deviceUuid, gatebluUuid, connector) =>
      @logEvent "gateblu-update-end", deviceUuid, gatebluUuid, connector

    deviceOptionsLoadBegin: (deviceUuid, gatebluUuid, connector) =>
      @logEvent "device-options-load-begin", deviceUuid, gatebluUuid, connector

    deviceOptionsLoadEnd: (deviceUuid, gatebluUuid, connector) =>
      @logEvent "device-options-load-end", deviceUuid, gatebluUuid, connector

    addDeviceEnd: (deviceUuid, gatebluUuid, connector) =>
      @logEvent "end", deviceUuid, gatebluUuid, connector

    logEvent: (state, deviceUuid, gatebluUuid, connector) =>
      payload =
        deploymentUuid: @deploymentUuid
        application: @APPLICATION
        workflow: @WORKFLOW
        userUuid: @userUuid
        state: state
        deviceUuid: deviceUuid
        gatebluUuid: gatebluUuid
        connector: connector

      skynetService.sendMessage
        devices: GATEBLU_LOGGER_UUID
        payload: payload
