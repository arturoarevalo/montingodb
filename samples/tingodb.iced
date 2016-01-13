db = require "../src/index"

await db.initialize __dirname + "/data", ["users"], defer error

if error
    console.log "Error initializing TingoDB", error
else
    console.log "TindoDB successfully initialized"

    await db.users.insert {name: "test user", email: "test@email.com"}, {w:1}, defer err, data
    console.log "inserted", data

    await db.users.findToArray {}, defer err, data
    console.log "all users", data
