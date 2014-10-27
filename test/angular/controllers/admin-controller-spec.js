describe('AdminController', function () {
  var sut, scope, groupService, permissionsService, $rootScope, $q, fakeWindow;

  beforeEach(function () {
    module('octobluApp');

    inject(function(_$httpBackend_){
      var $httpBackend = _$httpBackend_;
      $httpBackend.whenGET('/api/auth').respond(200);
      $httpBackend.whenGET('/pages/octoblu.html').respond(200);
      $httpBackend.whenGET('/pages/home.html').respond(200);
      $httpBackend.flush();
    });

    inject(function(_$rootScope_, _$q_, $controller){
      $q = _$q_;
      $rootScope = _$rootScope_;

      scope = $rootScope.$new();
      
      fakeWindow = new FakeWindow(); 

      // groupService = new GroupService();
      permissionsService = new PermissionsService();

      sut = $controller('AdminController', {
        $scope: scope,
        $window : fakeWindow,
        PermissionsService : permissionsService
      });
    });
  });

  it('should exist', function () {
    expect(sut).to.exist;
  });

  it('should call PermissionsService.allGroupPermissions() to find all the available group permissions', function(){
    sut.refreshGroups();
      expect(permissionsService.allGroupPermissions).to.have.been.called;
  });

  describe('When there are Group Permissions', function(){
    var groupPermissions = [{},{}];
    beforeEach(function(){
      permissionsService.allGroupPermissions.resolve(groupPermissions);
      $rootScope.$apply();
    });
    it('should add the list of Group Resource Permissions to the scope', function(){
      expect(scope.groups).to.deep.equal(groupPermissions);
    });

  });

  describe('When adding a new Group Permission',function(){

    it('should call PermissionService.add()', function(){
      scope.addGroup('n00bs');
      expect(permissionsService.add).to.have.been.calledWith({name: 'n00bs'});
    });
    
  });


  describe('deleteGroup', function(){

    describe('when the user confirms the delete', function () {
      beforeEach(function(){
        fakeWindow.confirm.returns = true;
      });

      it('should call the delete on the permissions service', function(){
        var permissionsUUID = '1234';
        scope.deleteGroup(permissionsUUID);
        expect(permissionsService.delete).to.have.been.calledWith(permissionsUUID);
      });
    });
  });


  var PermissionsService = function(){
    var self;
    self = this;

    self.add = sinon.spy(function(){
      var deferred = $q.defer();
      self.add.resolve = deferred.resolve;
      return deferred.promise;
    });

    self.delete = sinon.spy(function(){
      var deferred = $q.defer();
      self.delete.resolve = deferred.resolve;
      return deferred.promise;
    });

    self.allGroupPermissions = sinon.spy(function(){
      var deferred = $q.defer();
      self.allGroupPermissions.resolve = deferred.resolve;
      return deferred.promise;
    });
    self.allGroupPermissions.resolve = function(){};
    self.add.resolve = function(){};
    self.delete.resolve = function(){};
  };

  var State = function(){
    var self = this;
    self.params = {};
    self.go = sinon.spy();
  };

  var FakeWindow = function(){
    var _this = this;

    _this.confirm = sinon.spy(function(){
      return _this.confirm.returns;
    });

    return _this;
  };
});
