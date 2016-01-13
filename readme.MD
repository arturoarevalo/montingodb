# {mon}{tin}godb
A wrapper over MongoDB / TingoDB which allows to quickly switch between them. This allows to easily run in development environments applications that will require a full MongoDB, i.e. for prototyping or proof of concept versions.

## Installation
```
npm install montingodb
```

## Usage
```javascript
var db = require("montingodb");

// to use tingodb pass a directory name or use the tingodb() method
db.initialize("./data", ["collection1", "collection2", ...], callback);
db.tingodb("./data", ["collection1", "collection2", ...], callback);

// to use mongodb pass a mongodb connection url or use the mongodb() method
db.initialize("mongodb://localhost/dbname", ["collection1", "collection2", ...], callback);
db.tingodb("mongodb://localhost/dbname", ["collection1", "collection2", ...], callback);

// callback
function callback(err) {
    if(err) ...
}

// db.db contains the original MongoDB / TingoDB object
db.db.addUser(...);

// references to collections are automatically added 
db.collection1.insert(...);

// a helper "findToArray" method is added to the collection ...
db.collection1.findToArray(query, callback)
db.collection1.find(query).toArray(callback)

// ... for a shorter syntax in coffeescript-like languages
db.collection1.findToArray query, (err, data) ->
    console.log data

```
