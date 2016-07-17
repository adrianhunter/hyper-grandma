@Home_Connect = Home_Connect || {}

getHeaders = ()->
    user = Meteor.user()

    return {
        Accept: "application/vnd.bsh.sdk.v1+json"
        Authorization: "Bearer #{user.accessToken}"

    }
authHeader = ()->
    user = Meteor.user()

    return {
        Authorization: "Bearer #{user.accessToken}"

    }
getPostHeaders = ()->

    user = Meteor.user()

    return {
        'Content-Type': "application/vnd.bsh.sdk.v1+json"
        Authorization: "Bearer #{user.accessToken}"

    }
getStreamHeaders = ()->

    user = Meteor.user()

    return {
        'Content-Type': 'text/event-stream'
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
API_URL = Meteor.settings.public.API_URL + 'api/'

Home_Connect.Api = {

    registerEvent:(haId, cb)->
        console.log 'register event for', haId
        console.log headers: authHeader()
        eventSource = new EventSource(API_URL + "homeappliances/#{haId}/events",{
            headers: authHeader()
        })
        eventSource.onopen = (e,r)->
            console.log e,r, 'onMESSAGE'
        eventSource.addEventListener 'STATUS', ((e) ->
            console.log 'new event message'
            console.log e.data
            return
        ), false
        eventSource.addEventListener 'EVENT', ((e) ->
            console.log 'connection open'
            return
        ), false
        eventSource.addEventListener 'error', ((e) ->
            if e.readyState == EventSource.CLOSED
                console.log 'connection closed'
                # Connection was closed.
            else
            return
        ), false

#        HTTP.get API_URL + "homeappliances/#{haId}/events", {
#            headers: getStreamHeaders()
#        }, cb

    getProgramOptions: (programkey,haId, cb)->
        console.log programkey, 'programkey'
        console.log haId, 'haId'
        HTTP.get API_URL + "homeappliances/#{haId}/programs/available/#{programkey}", {
            headers: getHeaders()
        }, (e, r)->
            if e
                console.log e
                return
            if r?.content
                content = JSON.parse r.content
                console.log content
                options = content?.data.options
                currentProgramOptions = ProgramOptions.findOne programkey: programkey
                if options.length > 0
                    if currentProgramOptions
                        ProgramOptions.update({
                            _id: currentProgramOptions._id
                        },{
                            $set: options: options

                        })
                    else
                        ProgramOptions.insert({
                            programkey: programkey
                            options: options
                        })
                
                

            cb e,r if cb

#            currentPrograms = Programs.findOne({haId: haId})
    
    startProgram:(haId, programkey, cb)->
        console.log haId, 'haId'
        console.log programkey, 'programkey'
        HTTP.put API_URL + "homeappliances/#{haId}/programs/active", {
            headers: getPostHeaders()
            data: data: key: programkey

        }, (e, r)->
            if e then console.log e
            cb e,r if cb

    selectProgram: (haId,programkey, options, cb)->

        ## filter bugged options
        options = _.reject options, (opt)-> opt.key is "ConsumerProducts.CoffeeMaker.Option.CoffeeTemperature"


        params =
            data:
                key: programkey
                options: options

        console.log params

        

        HTTP.put API_URL + "homeappliances/#{haId}/programs/selected", {
            headers: getPostHeaders()
            data: params

        }, (e, r)->
            if e then console.log e
            cb e,r if cb

    updateProgramsForOneAppliance:(haId)->
        HTTP.get API_URL + "homeappliances/#{haId}/programs/available", {
            headers: getHeaders()
        }, (e, r)->
            if e then console.log e
            if r?.content
                content = JSON.parse r.content
                programs = content.data?.programs
                console.log content
                currentAppliance = Appliances.findOne haId: haId

                if currentAppliance
                    Appliances.update({
                        _id: currentAppliance._id
                    }, {
                        $set:
                            programs: programs
                    })

    updateAppliancePrograms: ->
        _.each Appliances.find().fetch(), (appliance, i)->
            do ->
                Meteor.setTimeout ->
                    HTTP.get API_URL + "homeappliances/#{appliance.haId}/programs/available", {
                        headers: getHeaders()
                    }, (e, r)->
                        if e then console.log e
                        if r?.content
                            content = JSON.parse r.content
                            programs = content.data?.programs
                            currentAppliance = Appliances.findOne haId: appliance.haId
                            console.log content
                            if currentAppliance
                                Appliances.update({
                                    _id: currentAppliance._id
                                }, {
                                    $set:
                                        programs: programs
                                })
                , 1000 * i


    updateApplianceProgramOptions:->
        self = @
        Appliances.find().forEach (appliance)->
            if appliance.programs
                do ->
                    appliance.programs.forEach (program)->
                        self.getProgramOptions appliance.haId, program.key


    updateAppliances: (cb)->
        HTTP.get(API_URL + 'homeappliances', {
            headers: getHeaders()
        }, (e, r)->
            if r?.content
                content = JSON.parse(r.content)
                appliances = content.data?.homeappliances
                console.log appliances

                if appliances
                    _.each appliances, (appliance)->
                        icon = getIconForAppliance appliance.type
                        appliance.icon = icon
                        currentAppliance = Appliances.findOne({name: appliance.name})
                        if currentAppliance
                            Appliances.update({
                                _id: currentAppliance._id
                            }, {
                                $set: appliance
                            })
                        else
                            Appliances.insert appliance
            else
                console.log e
        )
}
