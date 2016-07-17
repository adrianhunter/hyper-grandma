@ifDescriptionField = new ReactiveVar()
@thenDescriptionField = new ReactiveVar()

Template.create_recipe.events({
    'click .if-action': ->
        $('.modal-if').fadeIn()

    'click .then-action': ->
        $('.modal-then').fadeIn()


    'click .btn-close': ->
        $('.modal-if').fadeOut()
        $('.modal-then').fadeOut()

    'click .magic': ->
        recipe = {
            ifAction: IfField.get()
            ifDescription: IfCondition.get() or ifDescriptionField.get()
            thenAction: thenField.get()
            thenDescription: thenDescriptionField.get()
            haId: $('#oven').data('haid')
        }
        Meteor.call 'insertRecipe', recipe, (e,r) ->
            Router.go '/my_recipes'



})

Template.create_recipe.helpers({

    ifField: ->
        IfField.get()

    ifAction: ->
        if IfCondition.get()
            return IfCondition.get()
        if IfField.get() is ' Coffee Machine'
            ifDescriptionField.set('is Done')
        else if IfField.get() is 'Google Calendar'
            ifDescriptionField.set('Next appointment')
        else if IfField.get() is ' SMS'
            ifDescriptionField.set('Receive an sms')
        else if IfField.get() is ' Nest temperature'
            ifDescriptionField.set('Is over 30C')
        else if IfField.get() is ' Time'
            ifDescriptionField.set('At 7:30am')
        else if IfField.get() is 'Washing machine'
            ifDescriptionField.set('is Done')
        else if IfField.get() is ' Weather'
            ifDescriptionField.set('is Cloudy')
        else if IfField.get() is ' Oven'
            ifDescriptionField.set('is Done')
        else if IfField.get() is ' HUE Lights'
            ifDescriptionField.set('is on')
        else
            ifDescriptionField.set('Done')

        return ifDescriptionField.get()

    thenAction: ->
        if thenField.get() is ' Notification'
            thenDescriptionField.set('on the smartphone')
        else if thenField.get() is ' Coffee Machine'
            thenDescriptionField.set('Prepare coffee')
        else if thenField.get() is 'Amazon Pantry'
            thenDescriptionField.set('Make recurring order')
        else if thenField.get() is ' Nest temperature'
            thenDescriptionField.set('Set temp to 22C')
        else if thenField.get() is ' Time'
            thenDescriptionField.set('At 9:30am')
        else if thenField.get() is 'Washing machine'
            thenDescriptionField.set('Start laundry')
        else if thenField.get() is ' Call'
            thenDescriptionField.set('+49 17657797523')
        else if thenField.get() is ' Oven'
            thenDescriptionField.set('Start program')
        else if thenField.get() is ' HUE Lights'
            thenDescriptionField.set('Set cold atmosphere')

        return thenDescriptionField.get()

    thenField: ->
        thenField.get()

    submitButton: ->
        if IfField.get() and thenField.get()
            return true

})
