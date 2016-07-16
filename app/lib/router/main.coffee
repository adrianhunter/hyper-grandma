Router.map ->
  @route "home",
    path: "/"
    layoutTemplate: "homeLayout"

  @route "dashboard",
    path: "/dashboard"
    action: ->
      @render('dashboard', {
        data:
          template: 'appliancesContent'
          'homeappliances': [
            {
              'name': 'Backofen'
              'brand': 'Siemens'
              'vib': 'HN678G4S6'
              'connected': true
              'type': 'Oven'
              'enumber': 'HN678G4S6/09'
              'haId': 'SIEMENS-HN678G4S6-68A40E016875'
              icon: 'https://d30y9cdsu7xlg0.cloudfront.net/png/201067-200.png'
            }
            {
              'name': 'Kaffeevollautomat'
              'brand': 'Siemens'
              'vib': 'CT636LES6'
              'connected': true
              'type': 'CoffeeMaker'
              'enumber': 'CT636LES6/03'
              'haId': 'SIEMENS-CT636LES6-68A40E01237D'
              icon: 'http://www.freeiconspng.com/uploads/coffee-icon-png-44.png'
            }
            {
              'name': 'Kaffeevollautomat 2'
              'brand': 'BOSCH'
              'vib': 'CTL636ES6'
              'connected': true
              'type': 'CoffeeMaker'
              'enumber': 'CTL636ES6/03'
              'haId': 'BOSCH-CTL636ES6-68A40E003BF2'
              icon: 'http://www.freeiconspng.com/uploads/coffee-icon-png-44.png'
            }
            {
              'name': 'Trockner'
              'brand': 'BOSCH'
              'vib': 'WTYH77W0'
              'connected': true
              'type': 'Dryer'
              'enumber': 'WTYH77W0/01'
              'haId': 'BOSCH-WTYH77W0-68A40E008C04'
              icon: 'https://cdn2.iconfinder.com/data/icons/holiday-line-icons-1/48/48-512.png'
            }
            {
              'name': 'Trockner 2'
              'brand': 'Siemens'
              'vib': 'WT7YH7W0'
              'connected': true
              'type': 'Dryer'
              'enumber': 'WT7YH7W0/01'
              'haId': 'SIEMENS-WT7YH7W0-68A40E008C30'
              icon: 'https://cdn2.iconfinder.com/data/icons/holiday-line-icons-1/48/48-512.png'
            }
            {
              'name': 'Waschmaschine'
              'brand': 'BOSCH'
              'vib': 'WAYH2890'
              'connected': false
              'type': 'Washer'
              'enumber': 'WAYH2890/09'
              'haId': 'BOSCH-WAYH2890-68A40E009C8C'
              icon: 'http://www.freeiconspng.com/uploads/washing-machine-icon-22.jpg'
            }
            {
              'name': 'Geschirrspüler'
              'brand': 'BOSCH'
              'vib': 'SMS88TI26E'
              'connected': true
              'type': 'Dishwasher'
              'enumber': 'SMS88TI26E/11'
              'haId': 'BOSCH-SMS88TI26E-68A40E01FE2B'
              icon: 'http://www.clker.com/cliparts/6/E/t/s/m/m/hotel-icon-room-has-dishwasher-hi.png'
            }
            {
              'name': 'Geschirrspüler 2'
              'brand': 'Siemens'
              'vib': 'SN278I26TE'
              'connected': true
              'type': 'Dishwasher'
              'enumber': 'SN278I26TE/11'
              'haId': 'SIEMENS-SN278I26TE-68A40E00A6CC'
              icon: 'http://www.clker.com/cliparts/6/E/t/s/m/m/hotel-icon-room-has-dishwasher-hi.png'
            }
            {
              'name': 'Waschmaschine 2'
              'brand': 'Siemens'
              'vib': 'WM6YH890'
              'connected': false
              'type': 'Washer'
              'enumber': 'WM6YH890/09'
              'haId': 'SIEMENS-WM6YH890-68A40E009CAA'
              icon: 'http://www.freeiconspng.com/uploads/washing-machine-icon-22.jpg'
            }
            {
              'name': 'Kühl-Gefrier-Kombination'
              'brand': 'BOSCH'
              'vib': 'KGN36HI32'
              'connected': false
              'type': 'FridgeFreezer'
              'enumber': 'KGN36HI32/03'
              'haId': 'BOSCH-KGN36HI32-68A40E00EADA'
              icon: 'https://cdn2.iconfinder.com/data/icons/windows-8-metro-style/512/fridge.png'
            }
          ]

      })
      return


  @route "my_recipes",
    path: "/my_recipes"
    action: ->
      @render('dashboard', {
        data:
          template: 'my_recipes'
          #recipes: Recipes.find({user_id: Meteor.userId() },{sort: {createdAt: -1}}).fetch()
      })

  @route "create_recipes",
    path: "/create_recipe"
    action: ->
      @render('dashboard', {
        data:
          template: 'create_recipe'
          #recipes: Recipes.find({user_id: Meteor.userId() },{sort: {createdAt: -1}}).fetch()
      })
