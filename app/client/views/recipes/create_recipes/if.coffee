

@IfField = new ReactiveVar()
@IfCondition = new ReactiveVar()

Template.if_content.helpers
    ifField:-> IfField.get()
Template.if_content.events({

    'click .well':(event, instance) ->
        console.log event.target.innerText

        IfField.set(event.target.innerText)
        setTimeout ->
            IfCondition.set $('#select-if-condition').find('option:selected').val()
        ,1000


    'change #select-if-condition':(e)->
        console.log $('#select-if-condition').find('option:selected').val()
        IfCondition.set $('#select-if-condition').find('option:selected').val()

    'click .btn-success':->
        $('.modal-if').fadeOut()



})
