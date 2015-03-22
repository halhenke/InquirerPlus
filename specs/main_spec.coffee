require "./before"
inquirer = require "inquirer"
iPlus = require "../lib/inquirerPlus"
{ expect, should, Should, assert } = require 'chai'
sinon = require("sinon")

prompts = [
  {
    type: "list"
    name: "list"
    message: "a list"
    choices: [ "foo", new inquirer.Separator(), "bar", "bum"  ]
  }
  {
    type: "confirm"
    name: "confirm"
    message: "a confirm",
  }
  {
    type: "expand"
    name: "expand",
    message: "an expand",
    choices: [
      { key: "a", name: "acab"  }
      new inquirer.Separator()
      { key: "b", name: "bar"   }
      { key: "c", name: "chile" }
    ]
  }
]

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
        iPlus.inquirer.prompt.dog = "poodle"
      it 'should work normally', (done) ->
        prompts = [
          {
            type: "confirm"
            name: "q1"
            message: "message"
          }
          {
            type: "confirm"
            name: "q2"
            message: "message"
            default: false
          }
          {
            type: "input"
            name: "q3"
            message: "message"
            default: "A bad man"
          }
        ]

        # console.log iPlus
        # ui = this.prompt prompts, ( answers ) ->
        ui = iPlus.prompt prompts, ( answers ) ->

        # ui = iPlus.inquirer.prompt prompts, ( answers ) ->
          console.log "Back in the test - we got answers"
          console.log answers
          expect(answers.q1).to.be.true
          expect(answers.q2).to.be.false
          # expect(answers.q2).to.be.true
          expect(answers.q3).to.equal "abra cadabra"
          done()

        ui.rl.emit("line")
        ui.rl.emit("line")
        ui.rl.emit("line", "abra cadabra")

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






