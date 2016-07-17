
template = Template.store_recipe

template.onRendered ->
    $('.carousel').carousel interval: 2000

template.events
    'click .btn-add': (event,instance) ->
        console.log 'clicked'
        console.log event.target.id
        if event.target.id == 1 or event.target.id == '1'
            console.log 'abaacacaca'
            recipe = {
                ifAction: 'Fridge'
                ifDescription: 'is empty'
                thenAction: 'Amazon Pantry'
                thenDescription: 'Place order'
            }
        else if event.target.id == 2 or event.target.id == '2'
            console.log 'abaacacaca'
            recipe = {
                ifAction: 'Washing Machine'
                ifDescription: 'Laundry is done'
                thenAction: 'Notification'
                thenDescription: 'To smartphone'
            }
        else if event.target.id == 3 or event.target.id == '3'
            console.log 'abaacacaca'
            recipe = {
                ifAction: 'Time'
                ifDescription: 'is 7.30am'
                thenAction: 'Coffee machine'
                thenDescription: 'Make espresso'
            }

        Meteor.call 'insertRecipe', recipe, (e,r) ->
            if not e
                Router.go '/my_recipes'
            else
                console.log e
