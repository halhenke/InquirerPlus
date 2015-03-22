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
    # @inquirer = inquirer
    @prompt = @superPrompt
    @answers = {}
    @finalCall = undefined
    @topUI = null

  superPrompt: (prompts, allDone) ->
    @finalCall = allDone
    @promptSwitch prompts


  promptSwitch: (prompts) ->
    console.log prompts.length
    debugger
    if prompts.length
      switch lo.first(prompts).type
        when "oneOrMore"
          @oneOrMorePrompt prompts
        when "zeroOrMore"
          @zeroOrMorePrompt prompts
        when "getAList"
          @getAList prompts
        when "getAnObject"
          @getAnObject prompts
        else
          console.log "We went down here..."
          # console.log "@answers are: " + @answers
          # console.log "prompt is: " + prompt.name
          # console.log "in the superPrompt dog is " + @inquirer.prompt.dog
          # inquirer.prompt lo.take(prompt), @keepAnswers

          @topUI = @inquirer.prompt lo.take(prompts), (answers) =>
            lo.merge @answers, answers
            @promptSwitch lo.rest(prompts)
    else
      console.log "all the way to the end"
      @finalCall @answers

  ###
  Pass as a callback so that any underlying
  calls to enquirer will store answers so that
  we can call the actual completion callback later
  ###
  keepAnswers: (answers, type="simple") ->
    console.log "Answers to add: " + answers
    switch type
      when "list"
        [[key, val]] = lo.pairs(answers)
        if @answers[key]
          @answers[key].push val
        else
          @answers[key] = [val]
      when "object"
        if @answers[key]
          lo.merge @answers answers
        else
          @answers[key] = {answers}
      else
      # when "list"
        lo.merge @answers, answers
    # @superPrompt(lo.rest(prompts), allDone)


  ###
  A prompt to be asked at least once
  ###
  oneOrMorePrompt: (prompts) ->
    console.log "oneOrMorePrompt"
    @topUI = @inquirer.prompt lo.first(prompts).prompt, (answers) =>
      @keepAnswers answers, "list"
      @zeroOrMorePrompt prompts

  ###
  A prompt to be asked zero or more times
  ###
  zeroOrMorePrompt: (prompts) ->
    console.log "zeroOrMorePrompt"
    repeatPrompt =
      name: "zeroOrMoreTimes"
      type: "confirm"
      message: lo.first(prompts).repeatMessage
    @topUI = @inquirer.prompt [repeatPrompt], (answers) =>
      if answers.zeroOrMoreTimes
        @topUI = @inquirer.prompt lo.first(prompts).prompt, (answers) =>
          @keepAnswers answers, "list"
          @zeroOrMorePrompt prompts
      else
        @promptSwitch lo.rest prompts

  repeater: (prompt) ->
  getAList: (prompt) ->
  getAnObject: (prompt) ->
    console.log "getAnObject"



module.exports = new inquirerPlus
