angular.module('octobluApp')
  .constant 'AUTHENTICATOR_URIS', {
    EMAIL_PASSWORD: 'https://login.octoblu.com'
    GOOGLE: 'https://google-oauth.octoblu.com/login'
    CITRIX: 'https://citrix-oauth.octoblu.com/login'
    FACEBOOK: 'https://facebook-oauth.octoblu.com/login'
    TWITTER: 'https://twitter-oauth.octoblu.com/login'
    GITHUB: 'https://github-oauth.octoblu.com/login'
  }
  .constant 'OAUTH_PROVIDER', 'https://oauth.octoblu.com'
  .constant 'MESHBLU_HOST', 'meshblu.octoblu.com'
  .constant 'MESHBLU_PORT', '443'
  .constant 'PROFILE_URI', '#'
  .constant 'OCTOBLU_ICON_URL', 'https://ds78apnml6was.cloudfront.net/'
  .constant 'OCTOBLU_API_URL', 'https://app.octoblu.com'
  .constant 'CONNECTOR_DETAIL_SERVICE_URL', 'https://connector.octoblu.com'
  .constant 'FLOW_LOGGER_UUID', 'f952aacb-5156-4072-bcae-f830334376b1'
  .constant 'GATEBLU_LOGGER_UUID', '4dd6d1a8-0d11-49aa-a9da-d2687e8f9caf'
  .constant 'REGISTRY_URL', 'https://s3-us-west-2.amazonaws.com/nanocyte-registry/latest/registry.json'
  .constant 'CWC_TRUST_URL', 'https://trust-eastus-release-a.tryworkspacesapi.net'
  .constant 'CWC_AUTHENTICATOR_URL', "https://cwc-auth.octoblu.com"
  .constant "CWC_LOGIN_URL", "https://workspace.tryworkspaces.com/login"
  .constant "APP_STORE_URL", "https://store.octoblu.com"
