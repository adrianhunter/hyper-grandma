@Home_Connect = {}
# Request Meetup credentials for the user
# @param options {optional}
# @param credentialRequestCompleteCallback {Function} Callback function to call on
#   completion. Takes one argument, credentialToken on success, or Error on
#   error.

Home_Connect.requestCredential = (options, credentialRequestCompleteCallback) ->
    # support both (options, callback) and (callback).
    if !credentialRequestCompleteCallback and typeof options == 'function'
        credentialRequestCompleteCallback = options
        options = {}
    config = ServiceConfiguration.configurations.findOne(service: 'home_connect')
    if !config
        credentialRequestCompleteCallback and credentialRequestCompleteCallback(new (ServiceConfiguration.ConfigError))
        return
    # For some reason, meetup converts underscores to spaces in the state
    # parameter when redirecting back to the client, so we use
    # `Random.id()` here (alphanumerics) instead of `Random.secret()`
    # (base 64 characters).
    credentialToken = Random.secret()
    scope = options and options.requestPermissions or []
    flatScope = _.map(scope, encodeURIComponent).join('+')
    loginStyle = OAuth._loginStyle('home_connect', config, options)
#    http://localhost:3000/?code=be60ec2e-9cc3-48e8-8202-6103119d9bcb&state=homeconnect_auth&grant_type=authorization_code
#    https://api-preprod.home-connect.com/security/oauth/authorize?client_id=0342B8E0169CE3D2C716D443B24B8E4999466EE6C4E6DC049068BBE6B34922B2&response_type=code&scope=IdentifyAppliance&redirect_uri=http://localhost:3000?close&state=homeconnect_auth
#    https://api-preprod.home-connect.com/security/oauth/authorize?client_id=0342B8E0169CE3D2C716D443B24B8E4999466EE6C4E6DC049068BBE6B34922B2&response_type=code&scope=IdentifyAppliance&redirect_uri=http://localhost:3000/_oauth/home_connect?closeNaN
#    https://api-preprod.home-connect.com/security/oauth/authorize?response_type=code&redirect_uri=https%3A%2F%2Fapiclient.home-connect.com%2Fo2c.html&realm=apiclient.home-connect.com&client_id=b969d1de0fe374933c505b7f51f00405bfce74621475c5dab52500c90dbc0ffb&scope=IdentifyAppliance&state=homeconnect_auth
#    https://api-preprod.home-connect.com/security/oauth/authorize?client_id=0342B8E0169CE3D2C716D443B24B8E4999466EE6C4E6DC049068BBE6B34922B2&response_type=code&scope=IdentifyAppliance&redirect_uri=http://localhost:3000/_oauth/home_connect?close&state=homeconnect_auth
#    https://api-preprod.home-connect.com/security/oauth/authorize?client_id=0342B8E0169CE3D2C716D443B24B8E4999466EE6C4E6DC049068BBE6B34922B2&response_type=code&scope=IdentifyAppliance&redirect_uri=http://localhost:3000/_oauth/home_connect?close&state=homeconnect_auth
    loginUrl = 'https://api-preprod.home-connect.com/security/oauth/authorize' + '?client_id=' + config.clientId + '&response_type=code' + '&scope=' + 'IdentifyAppliance' + '&redirect_uri=' + 'http://localhost:3000/_oauth/home_connect' + '&state=homeconnect_auth'
    # meetup box gets taller when permissions requested.
    height = 620
    if _.without(scope, 'basic').length
        height += 130
    OAuth.launchLogin
        loginService: 'home_connect'
        loginStyle: loginStyle
        loginUrl: loginUrl
        credentialRequestCompleteCallback: credentialRequestCompleteCallback
        credentialToken: credentialToken
        popupOptions:
            width: 900
            height: height
    return




Accounts.oauth.registerService 'home_connect'
if Meteor.isClient

    Meteor.loginWithHome_Connect = (options, callback) ->
        # support a callback without options
        if !callback and typeof options == 'function'
            callback = options
            options = null

        foo = Accounts.oauth.credentialRequestCompleteHandler
        Accounts.oauth.credentialRequestCompleteHandler = (e,r)->
            console.log e,r

            return foo(e,r)
        credentialRequestCompleteCallback = Accounts.oauth.credentialRequestCompleteHandler(callback)

        Home_Connect.requestCredential options, credentialRequestCompleteCallback
        return

else
    Accounts.addAutopublishFields
        forLoggedInUser: [ 'services.home_connect' ]
        forOtherUsers: [ 'services.home_connect.id' ]
