@Home_Connect = Home_Connect || {}

getHeaders = ()->
    user = Meteor.user()

    return {
        Accept: "application/vnd.bsh.sdk.v1+json",
        Authorization: "Bearer #{user.accessToken}"

    }

getIconForAppliance = (type)->
    icons = [
        {
            'type': 'Oven'
            icon: 'https://d30y9cdsu7xlg0.cloudfront.net/png/201067-200.png'
        }
        {
            'type': 'CoffeeMaker'
            icon: 'http://www.freeiconspng.com/uploads/coffee-icon-png-44.png'
        }
        {
            'type': 'Dryer'
            icon: 'https://cdn2.iconfinder.com/data/icons/holiday-line-icons-1/48/48-512.png'
        }
        {
            'type': 'Washer'
            icon: 'http://www.freeiconspng.com/uploads/washing-machine-icon-22.jpg'
        }
        {
            'type': 'Dishwasher'
            icon: 'http://www.clker.com/cliparts/6/E/t/s/m/m/hotel-icon-room-has-dishwasher-hi.png'
        }
        {
            'type': 'FridgeFreezer'
            icon: 'https://cdn2.iconfinder.com/data/icons/windows-8-metro-style/512/fridge.png'
        }
    ]
    return (_.find icons, (icon)->
        return icon.type is type
    )?.icon
API_URL = 'https://api-preprod.home-connect.com/api/'

Home_Connect.Api = {
    updateAppliances: (cb)->
        HTTP.get(API_URL + 'homeappliances', {
            headers: getHeaders()
        }, (e, r)->
            if r?.content
                content = JSON.parse(r.content)
                appliances = content.data?.homeappliances

                if appliances
                    _.each appliances, (appliance)->
                        appliance.icon = getIconForAppliance appliance.type
                        currentAppliance = Appliances.findOne({hald: appliance.hald})
                        if currentAppliance
                            Appliances.update({
                                _id: currentAppliance._id
                            },appliance)
                        else
                            Appliances.insert appliance
            else
                console.log e
        )
}
