// Simply 'inherites' helpers from AccountsTemplates
Template.atPwdFormBtn.helpers(AccountsTemplates.atPwdFormBtnHelpers);
Template.atPwdFormBtn.events({
    'click .submit':function(e){
        e.preventDefault()
        Meteor.loginWithHome_Connect(function(e,r){

            Meteor.loginWithPassword('foo@foo.de', 'asdasd')
        })
    }
});
