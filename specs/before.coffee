mockery = require("mockery")
ReadlineStub = require("./helpers/readline")
mockery.enable()
mockery.warnOnUnregistered false
mockery.registerMock "readline2",
  createInterface: ->
    new ReadlineStub()
