inquirer = require "inquirer"

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
        prompt: {
          type: "input"
          name: "q1"
          message: "strong as oxe?"
        }
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
        prompt: {
          type: "input"
          name: "q11"
          message: "strong as oxe?"
        }
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


