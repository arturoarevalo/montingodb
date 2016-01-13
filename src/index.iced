module.exports =

    mongodb: (path, callback) ->
        err = "NOT IMPLEMENTED"

        if callback
            callback err

    tingodb: (path, callback) ->
        tingo = require "tingodb"
        Db = tingo({nativeObjectID: true}).Db

        module.exports.db = new Db path, {}
        await module.exports.db.compactDatabase defer err

        if callback
            callback err

    initialize: (path, collections, callback) ->

        err = null
        if path.startsWith "mongodb://"
            await module.exports.mongodb path, defer err
        else
            await module.exports.tingodb path, defer err

        if not err
            module.exports.db.__collection = module.exports.db.collection
            module.exports.db.collection = (name, options, cb) ->
                collection = this.__collection name, options, cb

                collection.findToArray = (query, cb) ->
                    result = this.find query
                    result.toArray cb

                return collection

            for name in collections
                module.exports[name] = module.exports.db.collection name

        if callback
            callback err
