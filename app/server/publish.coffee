Meteor.publish 'appliances',->
    return Appliances.find()
Meteor.publish 'programs',->
    return Programs.find()

Meteor.publish 'programOptions',->
    return ProgramOptions.find()

Meteor.publish 'recipes',->
    return Recipes.find()
