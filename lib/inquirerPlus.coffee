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
    @answers = {}
    @finalCall = undefined
    @topUI = null

  ###
  Stand-in for normal inquirer prompt function
  ###
  superPrompt: (prompts, allDone) ->
    @answers = {}
    @finalCall = allDone
    @promptSwitch prompts


  promptSwitch: (prompts) ->
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
          @topUI = @inquirer.prompt lo.take(prompts), (answers) =>
            lo.merge @answers, answers
            @promptSwitch lo.rest(prompts)
    else
      @finalCall @answers

  ###
  Pass as a callback so that any underlying
  calls to enquirer will store answers so that
  we can call the actual completion callback later
  ###
  keepAnswers: (answers, type="simple") ->
    switch type
      when "list"
        [[key, val]] = lo.pairs(answers)
        if @answers[key]
          @answers[key].push val
        else
          @answers[key] = [val]
      # when "object"
      #   if @answers[key]
      #     lo.merge @answers answers
      #   else
      #     @answers[key] = {answers}
      else
        lo.merge @answers, answers


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

  # getAList: (prompts) ->
  ###
    For collecting zero or more key/val pairs for an object
  ###
  getAnObject: (prompts) ->
    console.log "getAnObject"
    repeatPrompt =
      name: "addKeyVal"
      type: "confirm"
      message: lo.first(prompts).repeatMessage
    @topUI = @inquirer.prompt [repeatPrompt], (answers) =>
      console.log "answers.addKeyVal: ", answers.addKeyVal
      if answers.addKeyVal
        @topUI = @inquirer.prompt [lo.first(prompts).keyPrompt, lo.first(prompts).valPrompt], (answers) =>
          # @keepAnswers answers, "object"
          # console.log "key/val"
          # console.dir { 'age': 'indeterminate' }
          # WHY THE HELL DOESNT THIS WORK????
          # console.dir { answers.key: answers.val }
          # console.dir {}[answers.key] = answers.val
          # console.dir
            # answers.key: answers.val
          # console.dir [answers.key, answers.val]
          @answers[lo.first(prompts).name] = @answers[lo.first(prompts).name] || {}
          @answers[lo.first(prompts).name][answers.key] = answers.val
          # if @answers[lo.first(prompts).name]
          #   @answers[lo.first(prompts).name].merge {answers["key"]: answers.val}
          # else
          #   @answers[lo.first(prompts).name] = {answers.key: answers.val}

          @getAnObject prompts
      else
        @promptSwitch lo.rest prompts



module.exports = new inquirerPlus
