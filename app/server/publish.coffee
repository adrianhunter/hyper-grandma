Meteor.publish 'appliances',->
    return Appliances.find()
Meteor.publish 'programs',->
    return Programs.find()

Meteor.publish 'programOptions',->
    return ProgramOptions.find()
Meteor.publish 'home_notifications',->
    return HomeNotifications.find()

Meteor.publish 'recipes',->
    return Recipes.find()

Meteor.publish 'recipes_store',->
    return RecipesStore.find()
