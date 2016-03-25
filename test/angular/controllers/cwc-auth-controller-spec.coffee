describe 'CWCAuthController', ->
  beforeEach ->
    class FakeCWCAuthProxyService
      constructor: (@q) ->
        @authenticateCWCUser = sinon.stub()
        @createOctobluSession = sinon.stub()


    module 'octobluApp', ( $provide ) =>
      @cookies = {}
      @window = {}

      $provide.value '$state', go: sinon.spy()
      $provide.value '$window', @window
      $provide.value '$cookies', @cookies
      $provide.value  '$stateParams', {}
      $provide.value 'CWC_APP_STORE_URL', 'https://cwc-store.octoblu.com'
      return

    inject ($controller, $rootScope, $q, CWC_APP_STORE_URL) =>
      @q = $q
      @scope = $rootScope.$new()

      @fakeCWCAuthProxyService = new FakeCWCAuthProxyService @q
      @controller = $controller
      @CWC_APP_STORE_URL = CWC_APP_STORE_URL

  describe "->constructor", ->
    context "when the CWC user has not logged in before", ->
      describe "when given a valid oneTimePassword, customerId and cwcReferralUrl", ->
        beforeEach ->
          cwcAuthResult =
            cwcSessionId: "the-love-movement-was-the-last-album"
            cwcUserDevice:
              uuid: "the-ummah"
              token: "ali-shaheed-muhammad"

          @fakeCWCAuthProxyService.authenticateCWCUser.returns @q.when cwcAuthResult
          @sut = @controller 'CWCAuthController',
            $scope : @scope
            $state: @state
            $stateParams:
              otp : "stressed-out"
              customerId: "ATribeCalledQuest"
              cwcReferralUrl: @CWC_APP_STORE_URL
            CWC_APP_STORE_URL: @CWC_APP_STORE_URL
            CWCAuthProxyService: @fakeCWCAuthProxyService

          @scope.$digest()


        it "should try to authenticate the CWC user using the CWCAuthProxyService", ->
          expect(@fakeCWCAuthProxyService.authenticateCWCUser).to.have.been.calledWith("stressed-out", "ATribeCalledQuest", @CWC_APP_STORE_URL)

        it "should store the CWC Session Id and CWC Customer ID in the cookies", ->
          expect(@cookies.cwcSessionId).to.equal "the-love-movement-was-the-last-album"
          expect(@cookies.cwcCustomerId).to.equal "ATribeCalledQuest"

        it "should store the CWC Session Id and CWC Customer ID in the window", ->
          expect(@window.cwcSessionId).to.equal "the-love-movement-was-the-last-album"
          expect(@window.cwcCustomerId).to.equal "ATribeCalledQuest"

        it "should try to create an Octoblu Session", ->
          expect(@fakeCWCAuthProxyService.createOctobluSession).to.have.been.calledWith "the-ummah", "ali-shaheed-muhammad", @CWC_APP_STORE_URL
