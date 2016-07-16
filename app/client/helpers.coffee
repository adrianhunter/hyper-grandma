Template.registerHelper 'translateProgram', (key)->
    keys = key.split('.')
    return keys[keys.length-1]

Template.registerHelper 'flattenKey', (key)->
    return key.replace(/\./g,'_')

Template.registerHelper 'isMobile', ->
    return isMobile
