inquirer = require 'inquirer'
lo = require("lodash")

###
Similar to Ruby Array.wrap function
 - if arg is already an array simply returns the arg
 - otherwise returns argument wrapped in an Array
###
lo.mixin lo, {
  arrayWrap: (val) ->
    if lo.isArray(val)
      return val
    else
      return [ val ]
}

class inquirerPlus
  constructor: ->
    @inquirer = require("inquirer")
    @prompt = @superPrompt
    @answers =
      q1: true
      q2: false
      q3: "abra cadabra"
    @callBack

  # superPrompt = (prompts, answers = []) ->
  superPrompt: (prompts, allDone) ->
    for prompt in prompts
      # console.log prompt
      switch prompt.type
        when "oneOrMore"
          @oneOrMorePrompt prompt
        when "zeroOrMore"
          @zeroOrMorePrompt prompt
        when "getAList"
          @getAList prompt
        when "getAnObject"
          @getAnObject prompt
        else
          # console.log "We went down here..."
          # console.log "@answers are: " + @answers
          # console.log "prompt is: " + prompt.name
          # console.log "in the superPrompt dog is " + @inquirer.prompt.dog
          # @inquirer.prompt prompt, @keepAnswers
          @inquirer.prompt [prompt], (answers) ->
            console.log "answers called!: " + answers

    allDone @answers

  ###
  Pass as a callback so that any underlying
  calls to enquirer will store answers so that
  we can call the actual completion callback later
  ###
  keepAnswers: (answers) ->
    console.log "Answers to add: " + answers
    @answers = @answers.concat answers


  ###
  A prompt to be asked at least once
  ###
  oneOrMorePrompt: (prompt) ->
    @inquirer.prompt prompt, @keepAnswers
    repeatPrompt =
      name: "repeatPrompt"
      type: "confirm"
      message: prompt.repeatMessage
    @inquirer.prompt [repeatPrompt], (answers) ->
      if answers.repeatPrompt
        @inquirer.prompt prompt, (answers) ->
          keepAnswers(answers)
          zeroOrMorePrompt(prompt)
          # repeater(prompt)
  ###
  A prompt to be asked zero or more times
  ###
  zeroOrMorePrompt: (prompt) ->
    repeatPrompt =
      name: "zeroOrMoreTimes"
      type: "confirm"
      message: prompt.repeatMessage
    @inquirer.prompt [repeatPrompt], (answers) ->
      if answers.zeroOrMoreTimes
        @inquirer.prompt prompt, (answers) ->
          keepAnswers(answers)
          zeroOrMorePrompt(prompt)
          # repeater(prompt)

  repeater: (prompt) ->

  getAList: (prompt) ->
  getAnObject: (prompt) ->


module.exports = new inquirerPlus
