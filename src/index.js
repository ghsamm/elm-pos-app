require('./main.css')
const Elm = require('./AppTest.elm')

const root = document.getElementById('root')

Elm.AppTest.embed(root)
