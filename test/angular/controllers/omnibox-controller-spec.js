describe('OmniboxController', function () {
  var scope, sut, omniService, $q, $rootScope;

  beforeEach(function () {
    module('octobluApp');

    inject(function(_$rootScope_, _$q_, $controller){
      $q = _$q_;
      $rootScope = _$rootScope_;

      scope = $rootScope.$new();

      omniService = new FakeOmniService();

      sut = $controller('OmniboxController', {
        $scope: scope,
        OmniService: omniService
      });
    });
  });

  it('should exist', function () {
    expect(sut).to.exist;
  });

  describe('when items are added to scope.flowNodes', function () {
    beforeEach(function () {
      scope.flowNodes = [{type: 'flowNode'}];
      scope.$digest();
    });

    it('should call OmniService.fetch with flowNodes', function () {
      expect(omniService.fetch).to.have.been.calledWith(scope.flowNodes);
    });

    describe('when OmniService.fetch resolves', function () {
      beforeEach(function () {
        omniService.fetch.resolve([{type: 'flowNode'}, {type: 'nodeType'}]);
        $rootScope.$apply();
      });

      it('should add the omniItems to the omniList', function () {
        expect(scope.omniList).to.deep.contain({type: 'flowNode'});
        expect(scope.omniList).to.deep.contain({type: 'nodeType'});
      });
    });
  });

  describe('selectItem', function () {

    beforeEach(function(){
        scope.selectItem({type: 'item'});
    });

    it('should call OmniService.selectItem with the item', function () {
      expect(omniService.selectItem).to.have.been.called;
    });
  });

  // describe('when the OmniService emits a selected item', function () {
  //   beforeEach(function () {

  //   });
  // });

  var FakeOmniService = function(){
    var self = this;

    self.fetch = sinon.spy(function(){
      var deferred = $q.defer();
      self.fetch.resolve = deferred.resolve;
      return deferred.promise;
    });

    self.selectItem = sinon.spy(function(){
      var deferred = $q.defer();
      self.selectItem.resolve = deferred.resolve;
      return deferred.promise;
    });

  };
});
