const express = require('express')
const app = express()
const port = 8080
const version = "v0.7"

app.get('/', (req, res) => res.send(`Hello World from KC. Version: ${version}!`))

app.listen(port, () => console.log(`Listening on port ${port}. Version: ${version}!`))