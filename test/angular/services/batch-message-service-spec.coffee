describe "BatchMessageService", ->
  beforeEach ->
    module 'octobluApp', ($provide) =>
      #  @fakePermissionsService = new FakePermissionsService
      #  @fakeSkynetConnection = new FakeSkynetConnection
      #  @fakeSkynetService = new FakeSkynetService

      #  $provide.value 'PermissionService', @fakePermissionService
      #  $provide.value 'skynetService', @fakeSkynetService
      #  $provide.value 'reservedProperties', ['$$hashKey', '_id']
      #  $provide.value 'OCTOBLU_ICON_URL', ''
       return

    inject ( $q, $httpBackend, $rootScope) =>
      @q = $q
      @rootScope = $rootScope
      @scope = @rootScope.$new()
      # sinon.stub(@fakeSkynetService, 'getSkynetConnection').returns @q.when @fakeSkynetConnection

    inject (BatchMessageService) =>
      @sut = BatchMessageService

  it "should exist", ->
    expect(@sut).to.exist

  describe "parseMessages", ->

    it "should exist", ->
      expect(@sut.parseMessages).to.exist

    describe "when called with Messages", ->
      beforeEach ->
        @scope.$broadcast = sinon.spy()
        @pulseMessage =
          topic: 'pulse'
          payload:
            node: 'my-fancy-pulse'

        @errorMessage =
          topic: 'debug'
          payload:
            node: 'my-fancy-error'
            msg: 'fancy-msg'
            msgType: 'error'

        @debugMessage =
          topic: 'debug'
          payload:
            node: 'my-fancy-debug'
            msg: 'fancy-msg'
            msgType: 'debug'

      describe "when called with no messages", ->
        beforeEach ->
          @sut.parseMessages([], @scope)

        it "should do nothing if messages is empty", ->
          expect(@scope.$broadcast).to.not.have.been.called

      describe "when called with a debug message", ->
        beforeEach ->
          @sut.parseMessages([@debugMessage], @scope)

        it "should emit a debug message on the scope", ->
          expect(@scope.$broadcast).to.have.been.calledWith('flow-node-debug', @debugMessage)

      describe "when called with a error message", ->
        beforeEach ->
          @sut.parseMessages([@errorMessage], @scope)

        it "should emit a error message on the scope", ->
          expect(@scope.$broadcast).to.have.been.calledWith('flow-node-error', @errorMessage)

      describe "when called with a pulse message", ->
        beforeEach ->
          @sut.parseMessages([@pulseMessage], @scope)

        it "should emit a pulse message on the scope", ->
          expect(@scope.$broadcast).to.have.been.calledWith('flow-node-pulse', @pulseMessage)

      describe "when called with error, debug and pulse messages", ->
        beforeEach ->
          @sut.parseMessages([@errorMessage, @debugMessage, @pulseMessage], @scope)

        it "shuld emit a all messages", ->
          expect(@scope.$broadcast.calledThrice).to.be.true
          expect(@scope.$broadcast.firstCall).to.have.been.calledWith('flow-node-error', @errorMessage)
          expect(@scope.$broadcast.secondCall).to.have.been.calledWith('flow-node-debug', @debugMessage)
          expect(@scope.$broadcast.thirdCall).to.have.been.calledWith('flow-node-pulse', @pulseMessage)

  #   describe "when it is called", ->
  #     it "should return a promise", ->
  #       result = @sut.resetToken()
  #       expect(result.then).to.exist;
  #
  #     describe "when it is resolved with the token token5", ->
  #       beforeEach ->
  #         sinon.stub(@fakeSkynetConnection, 'resetToken').yields token: 'token5'
  #         _.defer @rootScope.$digest
  #         @sut.resetToken 'uuid3'
  #
  #       it "should call resetToken on the skynetConnection with the value uuid3", ->
  #         expect(@fakeSkynetConnection.resetToken).to.have.been.calledWith 'uuid3'
  #
  # class FakePermissionsService
  #
  # class FakeSkynetService
  #   getSkynetConnection: =>
  #
  # class FakeSkynetConnection
  #   constructor: ->
  #   on: =>
  #   mydevices: =>
  #   message: =>
  #   subscribe: =>
  #   resetToken: (uuid, callback) =>
  #
