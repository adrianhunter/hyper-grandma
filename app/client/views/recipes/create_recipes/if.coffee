@IfField = new ReactiveVar()

Template.if_content.events({

    'click .well':(event, instance) ->
        console.log event.target.innerText
        IfField.set(event.target.innerText)
        $('.modal-if').fadeOut()

})
