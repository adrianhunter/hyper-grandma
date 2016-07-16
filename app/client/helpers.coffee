Template.registerHelper 'translateProgram', (key)->
    keys = key.split('.')
    return keys[keys.length-1]
