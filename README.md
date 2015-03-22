# README

- A wrapper around the Inquirer library used in Yeoman, Slush etc to provide some extra functionality

## Why
- At present Inquirer doesnt really have a built in way to dynamically repeat questions/prompts based on user input
    + to achieve this the user is supposed to use the inquirer prompt recursively 
    + if one wants the option to get a set of answers from the user in the form of a list or an object then this involves a bit of fiddling and different scripts are needed for each situation
+ This package is intended to provide extra prompt types so that these sorts of things can be done without needing any extra scripting or need to worry about sequencing - just provide a list of prompts.
