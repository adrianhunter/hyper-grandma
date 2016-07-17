Template.my_recipes.events

    'click .create-recipe': ->
        Router.go('/create_recipe')
        $('.modal-create-recipe').fadeIn()

Template.create_recipe_modal.events

    'click .btn-close': ->
        $('.modal-create-recipe').fadeOut()
