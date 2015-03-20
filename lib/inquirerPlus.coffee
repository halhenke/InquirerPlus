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

inquirerPlus = ->
  # @inquirer: inquirer
  @inquirer: require(inquirer)
  @prompt: superPrompt

  superPrompt = (prompts, answers = []) ->
    for prompt in prompts
      switch prompt.oneOrMore
        oneOrMorePrompt prompt
      switch prompt.zeroOrMore
        zeroOrMorePrompt prompt
      switch prompt.getAList
        getAList prompt
      switch prompt.getAnObject
        getAnObject prompt
      else
        # plainInquirer prompt
        inquirer prompt


###
Will display prompt at least once and then prompt if the user wants to see it again
Should be able to take a single prompt or an array of prompts
###
oneOrMorePrompt = (prompt, answers = []) ->
  # fieldPromptAsk:
  #   type: "confirm"
  #   name: "moreFields"
  #   message: "Would you like to add (another) field to this model?"
  # fieldPromptKey:
  #   type: "input"
  #   name: "fieldName"
  #   message: "What is the name of this field?"
  # fieldPromptValue:
  #   type: "list"
  #   name: "fieldType"
  #   message: "What Keystone Field Type is this field?"
  #   choices: defaults.fieldList
  fpOnce: (prompt, answers) ->
    inquirer.prompt
  fpGo: (next) ->
    inquirer.prompt [@fieldPromptAsk], (answers) =>
      if answers.moreFields
        groupedAnswers.modelFields = groupedAnswers.modelFields or []
        @fpField(next)
      else
        next()
  fpField: (next) ->
    inquirer.prompt [@fieldPromptKey, @fieldPromptValue], (answers) =>
      groupedAnswers.modelFields.push(
        { key: answers.fieldName, val: answers.fieldType }
      )
      @fpGo(next)

  # ASYNC
  # TODO: Refactor into Gulp tasks
  # - sucks having 2 different concurrency managers to integrate
  async.series [
    (cb) ->
      inquirer.prompt initPrompts, (answers) ->
        lo.merge groupedAnswers, answers
        cb(null)
    (cb) ->
      fieldPrompts.fpGo(cb)
    (cb) ->
      inquirer.prompt finalPrompts, response(helpers, cb)
      ], (err, results) ->
        # gutil.log("To register the created routes with Keystone (express) - copy the app.get/post(...) lines from the file 'routes/index_#{groupedAnswers.resourceName}_routes.js' into the appropriate place in 'routes/index.js'")
        gutil.log("Voila...")
        done()
