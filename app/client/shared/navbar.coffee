Template.navbar.events
    'click .sliding-menu-controller': (e) ->
        menu = $('.sliding-menu')
        if menu.hasClass('show')
            menu.removeClass('show')
        else
            menu.addClass('show')



    'click .sliding-menu a': () ->
        $('#sliding-menu-controller').prop 'checked', false
