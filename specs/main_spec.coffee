require "./before"
inquirer = require "inquirer"
prompts = require "./fixtures/prompts"
iPlus = require "../lib/inquirerPlus"
{ expect, should, Should, assert } = require 'chai'
sinon = require("sinon")

expectedAnswers =
  list: "bar"
  confirm: true
  expand: "acab"

describe 'Extended prompt', ->
  describe 'Basic Functionality', ->
    # iPlus().prompt([2,4,6,8])
    console.log "-------------"
    # console.dir iPlus
    # console.log typeof iPlus
    console.log "-------------"
    # iPlus.prompt([2,4,6,8])


  describe 'Standard prompts', ->
    describe "when passed a bunch of standard prompts", ->
      beforeEach "mock the prompt", ->
        # this.prompt = inquirer.createPromptModule()
        # this.prompt = iPlus.inquirer.createPromptModule()

        # iPlus.inquirer.prompt = iPlus.inquirer.createPromptModule()

        # iPlus.inquirer.prompt = inquirer.createPromptModule()
        # sinon.spy(iPlus.inquirer)
        iPlus.inquirer.prompt.dog = "poodle"
      it 'should work normally', (done) ->

        # console.log iPlus
        # ui = inquirer.prompt prompts.simple, ( answers ) ->
        # ui = this.prompt prompts.simple, ( answers ) ->
        ui = iPlus.prompt prompts.simple, ( answers ) ->
        # ui = iPlus.inquirer.prompt prompts.simple, ( answers ) ->

        # ui = iPlus.inquirer.prompt prompts.simple, ( answers ) ->
          console.log "Back in the test - we got answers"
          console.log answers
          expect(answers.q1).to.be.true
          expect(answers.q2).to.be.false
          # expect(answers.q2).to.be.true
          expect(answers.q3).to.equal "abra cadabra"
          done()

        _ui = ui
        console.log "UI IS: "
        console.dir ui.rl
        # iPlus.inquirer.prompt.ui.rl.emit("line")
        # iPlus.inquirer.prompt.ui.rl.emit("line")
        # iPlus.inquirer.prompt.ui.rl.emit("line", "abra cadabra")

        rl = ui.rl
        iPlus.topUI.rl.emit("line")
        iPlus.topUI.rl.emit("line")
        iPlus.topUI.rl.emit("line", "abra cadabra")

        # console.log "line 1: #{_ui is ui}"
        # console.dir ui.rl
        # ui.rl.emit("line")
        # console.log "line 2: #{_ui is ui}"
        # console.dir ui.rl
        # ui.rl.emit("line")
        # console.log "line 3: #{_ui is ui}"
        # console.dir ui.rl
        # ui.rl.emit("line", "abra cadabra")
        # console.log "Final rl call: #{_ui is ui}"
        # console.dir ui.rl

        # ui.rl.emit("keypress", null, { name: "down" })
        # ui.rl.emit("line", "bla bla foo")

        # inquirer.prompts
        # inquirer.choices
        # inquirer.answers


  describe 'Repeating prompt', ->
    describe 'zero or more prompt', ->
      it 'should terminate when expected', ->
      it 'should return the expected answers', ->
    describe 'one or more prompt', ->
      it 'should terminate when expected', ->
      it 'should return the expected answers', ->

  describe 'List prompt', ->
  describe 'Object prompt', ->
  describe 'zero Or More Function', ->
    beforeEach ->
      # iPlus.inquirer.prompt = sinon.stub






