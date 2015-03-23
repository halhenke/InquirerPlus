inquirer = require "inquirer"

repeatObject =
  type: "getAnObject"
  name: "newUser"
  repeatMessage: "Would you like to define a key/value pair for your User?"
  keyPrompt:
    type: "input"
    name: "key"
    message: "Name a user attribute"
  valPrompt:
    type: "input"
    name: "val"
    message: "What is the value of this attribute"
    default: "bar"

module.exports =
  simple:
    [
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
  standard:
    [
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
  zero:
    [
      {
        type: "oneOrMore"
        repeatMessage: "Do you need me to ask again?"
        prompt:
          type: "input"
          name: "q1"
          message: "strong as oxe?"
      }
    ]
  mixed_with_one:
    [
      {
        type: "confirm"
        name: "q1"
        message: "message"
      }
      {
        type: "oneOrMore"
        repeatMessage: "Do you need me to ask again?"
        prompt:
          type: "input"
          name: "q2"
          message: "strong as ox?"
      }
      {
        type: "confirm"
        name: "q3"
        message: "message"
        default: false
      }
      {
        type: "input"
        name: "q4"
        message: "message"
        default: "A bad man"
      }
    ]
  mixed_with_zero:
    [
      {
        type: "confirm"
        name: "q1"
        message: "message"
      }
      {
        type: "zeroOrMore"
        # repeatMessage: "Do you need me to ask again?"
        repeatMessage: "Do you have any (more) dangerous skills to add?"
        prompt:
          type: "input"
          name: "q2"
          message: "Name a dangerous skill you possess"
      }
      {
        type: "confirm"
        name: "q3"
        message: "message"
        default: false
      }
      {
        type: "input"
        name: "q4"
        message: "message"
        default: "A bad man"
      }
    ]
  mixed_with_object:
    [
      {
        type: "confirm"
        name: "q1"
        message: "message"
      }
      repeatObject
      {
        type: "confirm"
        name: "q3"
        message: "message"
        default: false
      }
      {
        type: "input"
        name: "q4"
        message: "message"
        default: "A bad man"
      }
    ]

