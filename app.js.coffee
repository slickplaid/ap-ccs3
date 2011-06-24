express = require "express"
stylus = require "stylus"
require 'jade'

compile = (str,path)->
  console.log "Current string #{str} with path: #{path}"
  return stylus(str).set('filename', path).set('compress', true)

app = express.createServer()

app.configure 'development', ->
    app.use express.static __dirname + '/public'
    app.use express.errorHandler { dumpExceptions: true, showStack: true }

app.set 'view engine', 'jade'
app.use stylus.middleware {
  src: __dirname + "/stylus",
  dest: __dirname + "/public/stylesheet",
  compile: compile
}
app.use express.static __dirname + '/public'
app.use express.static __dirname + '/public/stylesheet'

app.get '/', (req, res)->
  res.render 'index', {title: 'CSS3 buttons'}
  
app.listen 3000