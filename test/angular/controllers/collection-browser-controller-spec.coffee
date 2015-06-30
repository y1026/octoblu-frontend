describe 'CollectionBrowserController', ->
  beforeEach ->
    module 'octobluApp', ($provide) =>
      $provide.value '$cookies', {}
      $provide.value '$intercom', sinon.stub()
      $provide.value '$intercomProvider', sinon.stub()
      $provide.value 'reservedProperties', ['$$hashKey', '_id']
      $provide.value 'OCTOBLU_ICON_URL', ''
      $provide.value('MESHBLU_HOST', 'http://whatever.com');
      $provide.value('MESHBLU_PORT', 1111)
      return

    inject ($controller, $rootScope) =>
      @scope = $rootScope.$new()
      @rootScope = $rootScope
      @sut = $controller 'CollectionBrowserController',
        $scope : @scope

  describe '->toggleActiveTab', ->
    beforeEach ->

    it 'should exist', ->
      expect(@sut.toggleActiveTab).to.exist

    it 'should default active tab to nodes on initialization', ->
      expect(@scope.tab.state).to.equal('nodes')

    describe 'when called with undefined or an empty string', ->
      beforeEach ->
        @sut.toggleActiveTab()
      it 'should not set the scope.tab.state', ->
        expect(@scope.tab).to.exist
        expect(@scope.tab.active).to.not.exist

    describe 'when called with flows', ->
      beforeEach ->
        @sut.toggleActiveTab('flows')
      it 'should set the scope.tab.state to flows', ->
        expect(@scope.tab.state).to.equal('flows')
      it 'should set scope.filterQuery to empty string', ->
        expect(@scope.filterQuery).to.equal('')

    describe 'when called with debug', ->
      beforeEach ->
        @sut.toggleActiveTab('debug')
      it 'should set the scope.tab.state to debug', ->
        expect(@scope.tab.state).to.equal('debug')

    describe 'when called with nodes', ->
      beforeEach ->
        @sut.toggleActiveTab('nodes')
      it 'should set the scope.tab.state to nodes', ->
        expect(@scope.tab.state).to.equal('nodes')
      it 'should set scope.filterQuery to empty string', ->
        expect(@scope.filterQuery).to.equal('')

    describe 'when called with any other value', ->
      beforeEach ->
        @sut.toggleActiveTab('wu-tang')
      it 'should set the scope.tab.state to undefined', ->
        expect(@scope.tab.state).to.not.exist