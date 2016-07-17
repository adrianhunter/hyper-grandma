EventSource = Npm.require 'eventsource'

Meteor.methods({

    registerEvents:(haId)->
        authHeader = ()->
            user = Meteor.user()

            return {
                Authorization: "Bearer #{user.accessToken}"

            }
        API_URL = 'https://api-preprod.home-connect.com/api/'

        eventSource = new EventSource(API_URL + "homeappliances/#{haId}/events",{
            headers: authHeader()
        })
        eventSource.onopen = (e,r)->
            console.log e,r, 'onMESSAGE'
        eventSource.addEventListener 'STATUS', (Meteor.bindEnvironment((e) ->
            console.log 'new event message'
            console.log e.data
            HomeNotifications.insert JSON.parse e.data
            return
        )), false
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

})
