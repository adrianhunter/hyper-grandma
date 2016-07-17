isPlaying = new ReactiveVar()
Template.recipe_card.helpers
    isPlaying:-> isPlaying.get()
#    ifDescription:->
#        condition = IfCondition.get()
#        if condition
#            return condition
Template.my_recipes.events

    'click .create-recipe': ->
        Router.go('/create_recipe')
        $('.modal-create-recipe').fadeIn()

Template.recipe_card.events
    'click .play-recipe':(e)->
        e.preventDefault()
        console.log 'play'
        Meteor.call('registerEvents','SIEMENS-HN678G4S6-68A40E016875',()->
            isPlaying.set(true)
        )
Template.create_recipe_modal.events


    'click .btn-close': ->
        $('.modal-create-recipe').fadeOut()

do ->
    init = true

    HomeNotifications.find().observeChanges({
        added:(b,a,c)->
            if !init
                console.log 'added new notification'
                console.log a
                if a.items
                    a.items.forEach (item)->
                        console.log item
                        if item.key is 'BSH.Common.Status.DoorState'
                            if item.value is 'BSH.Common.EnumType.DoorState.Open'
                                alert (123)
                                Meteor.call 'makeCall'



    })
    Meteor.setTimeout ->
        init = false

    ,1000
