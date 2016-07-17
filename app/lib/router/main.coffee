Router.map ->
    @route "home",
        path: "/"
        layoutTemplate: "homeLayout"
    @route 'appliance-actions',
        path: 'appliace-actions/:haId'
        action: ->
            @render('appliance_actions', {
                data:
                    'appliance': Appliances.findOne({haId: @params.haId})
            })
            return

    @route "dashboard",
        path: "/dashboard"
        action: ->
            @render('dashboard', {
                data:
                    template: 'appliancesContent'
                    'homeappliances': Appliances.find()
            })
            return

    @route "my_recipes",
        path: "/my_recipes"
        action: ->
            @render('dashboard', {
                data:
                    template: 'my_recipes'
                    recipes: Recipes.find({},{sort: {createdAt: -1}}).fetch()
            })

    @route "create_recipes",
        path: "/create_recipe"
        action: ->
            @render('dashboard', {
                data:
                    template: 'create_recipe'
                    recipes: Recipes.find({},{sort: {createdAt: -1}}).fetch()
            })

    @route "store_recipes",
        path: "/store_recipe"
        action: ->
            @render('dashboard', {
                data:
                    template: 'store_recipe'
                    recipes: RecipesStore.find({},{sort: {createdAt: -1}}).fetch()
            })
