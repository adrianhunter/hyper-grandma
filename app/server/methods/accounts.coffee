Meteor.methods
	deleteAccount: (userId) ->
		if @userId == userId
			Meteor.users.remove _id: @userId

	makeCall: () ->
		HTTP.post("https://api.twilio.com/2010-04-01/Accounts/" + Meteor.settings.twilioApplicationId + "/Calls", {
			headers:
				Authorization: Meteor.settings.twilioAuthorization
			params:
				From: Meteor.settings.twilioFrom
				To: Meteor.settings.twilioTo
				Url: 'http://demo.twilio.com/docs/voice.xml'
		})

	insertRecipe: (recipe) ->
		Recipes.insert(recipe)
