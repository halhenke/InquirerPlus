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
# module.exports = inquirerPlus()



# # inquirerPlus = ->
#   # inquirerPlus =
#   #   inquirer: require("inquirer")
#   #   prompt: @superPrompt
#   inquirerPlus = ->
#     @inquirer = require("inquirer")
#     @prompt = superPrompt
#     return

#   superPrompt = (prompts, answers = []) ->
#     for prompt in prompts
#       console.log prompt
#       # switch prompt
#       # when prompt.oneOrMore
#       #   @oneOrMorePrompt prompt
#       # when prompt.zeroOrMore
#       #   @zeroOrMorePrompt prompt
#       # when prompt.getAList
#       #   @getAList prompt
#       # when prompt.getAnObject
#       #   @getAnObject prompt
#       # else
#       #   # plainInquirer prompt
#       #   inquirer prompt

#   oneOrMorePrompt = (prompt) ->
#   zeroOrMorePrompt = (prompt) ->
#   getAList = (prompt) ->
#   getAnObject = (prompt) ->

#   # inquirerPlus =
#   #   inquirer: require("inquirer")
#   #   prompt: @superPrompt

#   return inquirerPlus()

# # inquirerPlusHash =
# #   # inquirerPlus =
# #   #   inquirer: require("inquirer")
# #   #   prompt: @superPrompt
# #   inquirerPlus = ->
# #     @inquirer = require("inquirer")
# #     # @prompt = superPrompt

# #   inquirerPlus.superPrompt = (prompts, answers = []) ->
# #     for prompt in prompts
# #       console.log prompt
# #       # switch prompt
# #       # when prompt.oneOrMore
# #       #   @oneOrMorePrompt prompt
# #       # when prompt.zeroOrMore
# #       #   @zeroOrMorePrompt prompt
# #       # when prompt.getAList
# #       #   @getAList prompt
# #       # when prompt.getAnObject
# #       #   @getAnObject prompt
# #       # else
# #       #   # plainInquirer prompt
# #       #   inquirer prompt

# #   oneOrMorePrompt = (prompt) ->
# #   zeroOrMorePrompt = (prompt) ->
# #   getAList = (prompt) ->
# #   getAnObject = (prompt) ->

# #   # inquirerPlus =
# #   #   inquirer: require("inquirer")
# #   #   prompt: @superPrompt

# #   return inquirerPlus()

# # module.exports = inquirerPlus()

# # ###
# # Will display prompt at least once and then prompt if the user wants to see it again
# # Should be able to take a single prompt or an array of prompts
# # ###
# # oneOrMorePrompt = (prompt, answers = []) ->
# #   # fieldPromptAsk:
# #   #   type: "confirm"
# #   #   name: "moreFields"
# #   #   message: "Would you like to add (another) field to this model?"
# #   # fieldPromptKey:
# #   #   type: "input"
# #   #   name: "fieldName"
# #   #   message: "What is the name of this field?"
# #   # fieldPromptValue:
# #   #   type: "list"
# #   #   name: "fieldType"
# #   #   message: "What Keystone Field Type is this field?"
# #   #   choices: defaults.fieldList
# #   fpOnce: (prompt, answers) ->
# #     inquirer.prompt
# #   fpGo: (next) ->
# #     inquirer.prompt [@fieldPromptAsk], (answers) =>
# #       if answers.moreFields
# #         groupedAnswers.modelFields = groupedAnswers.modelFields or []
# #         @fpField(next)
# #       else
# #         next()
# #   fpField: (next) ->
# #     inquirer.prompt [@fieldPromptKey, @fieldPromptValue], (answers) =>
# #       groupedAnswers.modelFields.push(
# #         { key: answers.fieldName, val: answers.fieldType }
# #       )
# #       @fpGo(next)

# #   # ASYNC
# #   # TODO: Refactor into Gulp tasks
# #   # - sucks having 2 different concurrency managers to integrate
# #   async.series [
# #     (cb) ->
# #       inquirer.prompt initPrompts, (answers) ->
# #         lo.merge groupedAnswers, answers
# #         cb(null)
# #     (cb) ->
# #       fieldPrompts.fpGo(cb)
# #     (cb) ->
# #       inquirer.prompt finalPrompts, response(helpers, cb)
# #       ], (err, results) ->
# #         # gutil.log("To register the created routes with Keystone (express) - copy the app.get/post(...) lines from the file 'routes/index_#{groupedAnswers.resourceName}_routes.js' into the appropriate place in 'routes/index.js'")
# #         gutil.log("Voila...")
# #         done()
