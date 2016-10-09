local eval = require('eval')

print("\nType a sentence and hit enter to submit.")
print("CTRL+C then enter to quit.\n")
while true do
    io.write("you> ")
    io.flush()
    io.write(print(eval.say(io.read())))
    io.flush()
end


