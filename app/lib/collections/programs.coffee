@Programs = new Mongo.Collection('programs')
@ProgramOptions = new Mongo.Collection('program_options')


#ProgramsSchema = new SimpleSchema
#    key:
#        type: String
#    options:
#        type: [Object]
#        blackbox: true
#
#
#
#Programs.attachSchema ProgramsSchema
