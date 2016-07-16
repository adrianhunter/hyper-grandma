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

})
