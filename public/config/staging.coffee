angular.module('octobluApp')
  .constant 'AUTHENTICATOR_URIS', {
    EMAIL_PASSWORD: 'https://login-staging.octoblu.com'
    GOOGLE: 'https://google-oauth-staging.octoblu.com/login'
    CITRIX: 'https://citrix-oauth-staging.octoblu.com/login'
    FACEBOOK: 'https://facebook-oauth-staging.octoblu.com/login'
    TWITTER: 'https://twitter-oauth-staging.octoblu.com/login'
    GITHUB: 'https://github-oauth-staging.octoblu.com/login'
  }
  .constant 'OAUTH_PROVIDER', 'https://oauth-staging.octoblu.com'
  .constant 'MESHBLU_HOST', 'meshblu-staging.octoblu.com'
  .constant 'MESHBLU_PORT', '443'
  .constant 'OCTOBLU_ICON_URL', 'https://ds78apnml6was.cloudfront.net/'
  .constant 'OCTOBLU_API_URL', 'https://staging-api.octoblu.com'
  .constant 'CONNECTOR_DETAIL_SERVICE_URL', 'https://connector.octoblu.com'
  .constant 'FLOW_LOGGER_UUID', 'f952aacb-5156-4072-bcae-f830334376b1'
  .constant 'GATEBLU_LOGGER_UUID', '4dd6d1a8-0d11-49aa-a9da-d2687e8f9caf'
  .constant 'CWC_TRUST_URL', 'https://trust-eastus-release-a.tryworkspacesapi.net'
  .constant 'CWC_AUTHENTICATOR_URL', "http://cwc-auth.octoblu.com"
  .constant "CWC_LOGIN_URL", "https://workspace.tryworkspaces.com/login"
