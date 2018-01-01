#!/usr/bin/env ruby
require "highline/import"
 temp=ask "What is your favorite color? "
puts temp


choose do |menu|
  menu.prompt = "Please choose your favorite programming language?  "
  menu.choice(:ruby) { say("Good choice!") }
  menu.choices(:python, :perl) { say("Not from around here, are you?") }
end


say("\nThis is with a different layout...")
choose do |menu|
  menu.layout = :one_line

  menu.header = "Languages"
  menu.prompt = "Favorite? "

  menu.choice :ruby do say("Good choice!") end
  menu.choices(:python, :perl) do say("Not from around here, are you?") end
end
