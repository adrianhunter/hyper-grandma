@Appliances = new Mongo.Collection('appliances')


#DevicesSchema = new SimpleSchema
#    owner:
#        type: String
#    name:
#        type: String
#    type:
#        type: String
#    createdAt:
#        type: Date
#        autoValue:->
#            if @isInsert
#                new Date()
#    updatedAt:
#        type: Date
#        autoValue:->
#            if @isUpdate
#                new Date()
#
#
#
#Devices.attachSchema DevicesSchema
