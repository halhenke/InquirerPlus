require "./before"
inquirer = require "inquirer"
prompts = require "./fixtures/prompts"
iPlus = require "../lib/inquirerPlus"
{ expect, should, Should, assert } = require 'chai'
sinon = require("sinon")

describe 'Extended prompt', ->
  describe 'Basic Functionality', ->

  describe 'Standard prompts', ->
    describe "when passed a bunch of standard prompts", ->
      beforeEach "mock the prompt", ->
        # this.prompt = inquirer.createPromptModule()
        # iPlus.inquirer.prompt = inquirer.createPromptModule()
        # sinon.spy(iPlus.inquirer)
      it 'should work normally', (done) ->
        ui = iPlus.prompt prompts.simple, ( answers ) ->
          console.log "Back in the test - we got answers"
          console.log answers
          expect(answers.q1).to.be.true
          expect(answers.q2).to.be.false
          expect(answers.q3).to.equal "abra cadabra"
          done()

        iPlus.topUI.rl.emit("line")
        iPlus.topUI.rl.emit("line")
        iPlus.topUI.rl.emit("line", "abra cadabra")



  describe 'Repeating prompt', ->
    describe 'zero or more prompt', ->
      it 'should return the expected answers', (done) ->
        iPlus.prompt prompts.mixed_with_zero, (answers) ->
          expect(answers.q1).to.be.true
          expect(answers.q2).to.eql ["Ninja Kicks", "Knife Throwing", "Driving While Tired"]
          expect(answers.q3).to.be.false
          expect(answers.q4).to.equal "abra cadabra"
          done()

        iPlus.topUI.rl.emit("line")
        # repeating question
        iPlus.topUI.rl.emit("line", "Y")
        iPlus.topUI.rl.emit("line", "Ninja Kicks")
        iPlus.topUI.rl.emit("line", "Y")
        iPlus.topUI.rl.emit("line", "Knife Throwing")
        iPlus.topUI.rl.emit("line", "Y")
        iPlus.topUI.rl.emit("line", "Driving While Tired")
        iPlus.topUI.rl.emit("line", "n")
        iPlus.topUI.rl.emit("line")
        iPlus.topUI.rl.emit("line", "abra cadabra")

    describe 'one or more prompt', ->
      it 'should return the expected answers', (done) ->
        iPlus.prompt prompts.mixed_with_one, (answers) ->
          expect(answers.q1).to.be.true
          expect(answers.q2).to.eql ["i am", "actually maybe not...", "ok - i am"]
          expect(answers.q3).to.be.false
          expect(answers.q4).to.equal "abra cadabra"
          done()

        iPlus.topUI.rl.emit("line")
        # repeating question
        iPlus.topUI.rl.emit("line", "i am")
        iPlus.topUI.rl.emit("line", "Y")
        iPlus.topUI.rl.emit("line", "actually maybe not...")
        iPlus.topUI.rl.emit("line", "Y")
        iPlus.topUI.rl.emit("line", "ok - i am")
        iPlus.topUI.rl.emit("line", "n")
        iPlus.topUI.rl.emit("line")
        iPlus.topUI.rl.emit("line", "abra cadabra")


  describe 'List prompt', ->
  describe 'Object prompt', ->
    it 'should return the expected answers', (done) ->
      iPlus.prompt prompts.mixed_with_object, (answers) ->
        expect(answers.q1).to.be.true
        # expect(answers.q2).to.eql
        expect(answers.newUser).to.eql
          name: "Brian"
          messiah: "definitely"
          age: "indeterminate"
        expect(answers.q3).to.be.false
        expect(answers.q4).to.equal "abra cadabra"
        done()

      iPlus.topUI.rl.emit("line")
      # repeating question
      iPlus.topUI.rl.emit("line", "Y")
      iPlus.topUI.rl.emit("line", "name")
      iPlus.topUI.rl.emit("line", "Brian")
      iPlus.topUI.rl.emit("line", "Y")
      iPlus.topUI.rl.emit("line", "messiah")
      iPlus.topUI.rl.emit("line", "definitely")
      iPlus.topUI.rl.emit("line", "Y")
      iPlus.topUI.rl.emit("line", "age")
      iPlus.topUI.rl.emit("line", "indeterminate")
      iPlus.topUI.rl.emit("line", "n")
      iPlus.topUI.rl.emit("line")
      iPlus.topUI.rl.emit("line", "abra cadabra")

