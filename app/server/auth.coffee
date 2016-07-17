ServiceConfiguration.configurations.upsert { service: 'home_connect' }, $set:
    clientId: '0342B8E0169CE3D2C716D443B24B8E4999466EE6C4E6DC049068BBE6B34922B2'
    secret: '0342B8E0169CE3D2C716D443B24B8E4999466EE6C4E6DC049068BBE6B34922B2'


Home_Connect = {}
OAuth.registerService 'home_connect', 2, null, (query) ->
    accessToken = getAccessToken(query)
    identity = {
        id: query.code
        login: 'fooo'
        name:'homeConnectUser'
    }
    emails = [
        {
            address: 'foo@goo.de'
            primary: true
        }
    ]
    primaryEmail = _.findWhere(emails, primary: true)

    currentUser = Meteor.users.findOne({
        username: identity.name
    })

    if not currentUser
        created = Accounts.createUser({
            username: identity.name
            email : 'foo@foo.de'
            password : 'asdasd'
        })

        Meteor.users.update({
            username: identity.name
        }, {
            $set: accessToken: accessToken
        })

    {
        serviceData:
            id: identity.id
            accessToken: OAuth.sealSecret(accessToken)
            email: identity.email or primaryEmail and primaryEmail.email or ''
            username: identity.login
            emails: emails
        options: profile: name: identity.name
    }
# http://developer.github.com/v3/#user-agent-required
userAgent = 'Meteor'
if Meteor.release
    userAgent += '/' + Meteor.release

getAccessToken = (query) ->
    config = ServiceConfiguration.configurations.findOne(service: 'home_connect')
    if !config
        throw new (ServiceConfiguration.ConfigError)
    response = undefined
    try
        response = HTTP.post(Meteor.settings.public.API_URL + 'security/oauth/token',
            headers:
                Accept: 'application/json'
                'User-Agent': userAgent
            params:
                code: query.code
                grant_type: query.grant_type
                client_id: config.clientId
                redirect_uri: 'http://localhost:3000/_oauth/home_connect'
                state: query.state
        )
    catch err
#        throw _.extend(new Error('Failed to complete OAuth handshake with Home_Connect. ' + err.message), response: err.response)
    if response.data.error
        # if the http response was a json object with an error attribute
        throw new Error('Failed to complete OAuth handshake with GitHub. ' + response.data.error)
    else




        return response.data.access_token
    return
#
#getIdentity = (accessToken) ->
#    try
#        return HTTP.get('https://api-preprod.home-connect.com/user',
#            headers: 'User-Agent': userAgent
#            params: access_token: accessToken).data
#    catch err
#        throw _.extend(new Error('Failed to fetch identity from Home_Connect. ' + err.message), response: err.response)
#    return

#getEmails = (accessToken) ->
#    try
#        return HTTP.get('https://api.github.com/user/emails',
#            headers: 'User-Agent': userAgent
#            params: access_token: accessToken).data
#    catch err
#        return []
#    return

Home_Connect.retrieveCredential = (credentialToken, credentialSecret) ->
    OAuth.retrieveCredential credentialToken, credentialSecret

# ---
# generated by js2coffee 2.2.0
