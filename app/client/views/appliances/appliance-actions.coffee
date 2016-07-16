@SelectedProgam = new ReactiveVar()


Template.appliance_actions.helpers({
    
    selectedProgram: -> SelectedProgam.get()

    
})

Template.appliance_actions.events({
    'click .select-program':->
        router = Router.current()

        cachedProgramOptions = ProgramOptions.findOne({
            programkey: @key
        })

        if not cachedProgramOptions
            Home_Connect.Api.getProgramOptions @key,router.params.haId, (e,r)=>
            if not e
                SelectedProgam.set(@key)
        else
            SelectedProgam.set(@key)


})

Template.appliance_actions.onDestroyed ->
    SelectedProgam.set(false)



#other template....

Template.appliance_actions_options_form.helpers({

    programOptions: ->
        programOptions = ProgramOptions.findOne({
            programkey: SelectedProgam.get()
        })

        if programOptions
            console.log programOptions.options
            return programOptions.options
        else
            return []

    constraintsArray:-> _.map @constraints, (constraint)-> constraint


})
Template.appliance_actions_options_form.events({

    'click .submit-options':(e)->
        e.preventDefault()
        options = []
        router = Router.current()
        programOptions = ProgramOptions.findOne({
            programkey: SelectedProgam.get()
        })
        _.each programOptions.options, (option)->
            selector = option.key.replace(/\./g,'_')
            myoption = {
                key: option.key

            }
            if option.type is 'Boolean'
                myoption.value = $("[name=#{selector}]")?[0].checked
            else
                myoption.value = $("[name=#{selector}]").val()
            if option.type is 'Int'
                myoption.value = parseInt(myoption.value)

            if option.type is 'Enum'
                myoption.value = myoption.value.replace(/\_/g,'.')

            unit = $("[name=#{selector}]").data('unit')
            if unit
                myoption.unit = unit
            options.push(myoption)

        Home_Connect.Api.selectProgram router.params.haId, SelectedProgam.get(), options, (e,r)->
            console.log e,r
            if not e
                Home_Connect.Api.startProgram router.params.haId, SelectedProgam.get(), (e,r)->
                    

    'click .cancel-options':(e)->
        e.preventDefault()
        SelectedProgam.set(false)

})


Template.appliance_actions_options_form.onRendered ->
    $.material.init()

