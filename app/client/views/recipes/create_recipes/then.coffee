@thenField = new ReactiveVar()

Template.then_content.events({

    'click .well':(event, instance) ->
        console.log event.target.innerText
        thenField.set(event.target.innerText)
        $('.modal-then').fadeOut()

})
