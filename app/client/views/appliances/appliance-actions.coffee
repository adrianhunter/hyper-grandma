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
        $('#program-options-form')


})


Template.appliance_actions_options_form.onRendered ->
    $.material.init()

