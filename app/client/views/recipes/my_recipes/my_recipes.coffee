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
        Meteor.call('registerEvents','BOSCH-HNG6764S6-68A40E003BEE',()->
            isPlaying.set(true)
        )
Template.recipe_notification_modal.events
    'click .btn-close':->
        $('.modal-recipe-notification').fadeOut()
        
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
                                $('.modal-recipe-notification').fadeIn()
                                console.log 'ring phone!!!'
                                Meteor.call 'makeCall'



    })
    Meteor.setTimeout ->
        init = false

    ,1000
