// Simply 'inherites' helpers from AccountsTemplates
Template.atPwdFormBtn.helpers(AccountsTemplates.atPwdFormBtnHelpers);
Template.atPwdFormBtn.events({
    'click #at-btn':function(e){
        e.preventDefault()

        Meteor.loginWithHome_Connect({
            requestPermissions: [
                'ControlAppliance',

                'Control',
                'Oven-Control',
                'Washer-Control',
                'Dryer-Control',
                // 'Coffeemaker-Control',
                'Dishwasher-Control',
                'IdentifyAppliance',
                //
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
