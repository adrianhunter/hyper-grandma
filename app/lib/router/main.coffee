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
        waitOn: ->
            [
                subs.subscribe 'posts'
                subs.subscribe 'comments'
                subs.subscribe 'attachments'
            ]
        data: ->
            posts: Posts.find({}, {sort: {createdAt: -1}}).fetch()
        action: ->
            @render('dashboard', {
                data:
                    'homeappliances': Appliances.find()

            })
            return
