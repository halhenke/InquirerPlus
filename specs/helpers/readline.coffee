EventEmitter = require("events").EventEmitter
sinon = require("sinon")
util = require("util")
_ = require("lodash")
stub =
  write: sinon.stub().returns(stub)
  moveCursor: sinon.stub().returns(stub)
  setPrompt: sinon.stub().returns(stub)
  close: sinon.stub().returns(stub)
  pause: sinon.stub().returns(stub)
  resume: sinon.stub().returns(stub)
  _getCursorPos: sinon.stub().returns(stub)
  output:
    end: sinon.stub().returns(stub)
    mute: sinon.stub().returns(stub)
    unmute: sinon.stub().returns(stub)
    write: sinon.stub().returns(stub)

ReadlineStub = ->
  EventEmitter.apply this, arguments
  return

util.inherits ReadlineStub, EventEmitter
_.assign ReadlineStub::, stub
module.exports = ReadlineStub
