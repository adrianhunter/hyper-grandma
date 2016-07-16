// Simply 'inherites' helpers from AccountsTemplates
Template.atSignupLink.helpers(AccountsTemplates.atSignupLinkHelpers);

// Simply 'inherites' events from AccountsTemplates
Template.atSignupLink.events({
    'click #at-signUp':function(e) {
        e.preventDefault();
        Meteor.loginWithHome_Connect({
            requestPermissions: [
                'ControlAppliance',
                'RemoteStart',
                'Control',
                'Oven-Control',
                'Washer-Control',
                'Dryer-Control',
                'Coffeemaker-Control',
                'Dishwasher-Control',
                'IdentifyAppliance',
                'Monitor',
                'Oven-Monitor',
                'Dishwasher-Monitor',
                'Washer-Monitor',
                'Dryer-Monitor',
                'CoffeeMaker-Monitor',
                'MonitorAppliance'
            ]
        },function(e,r){

            Meteor.loginWithPassword('foo@foo.de', 'asdasd')
        })
    }
});
