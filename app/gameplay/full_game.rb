def full_game
    prompt = prompt_instance

    instructions

    game = Game.create(score: 0)
    game.lost = false
    user = User.new
    num_badgers = 2

    while game.lost == false do
        gameplay(user, game, num_badgers)
        num_badgers += 1
        if num_badgers > 20
            system "clear"
            prompt.ok("CONGRATULATIONS!")
            prompt.ok("You beat BADGERS AND GYMS!")
            sleep(2)
            break
        end
    end
    if Game.high_scores.any? {|g| game.score > g.score} || Game.high_scores.length < 10
        enter_name(game)
    end
    system "clear"
    display_high_scores
    user_input = prompt.select("Would you like to play again?", ["Yes", "No"])
    case user_input
    when "Yes"
        full_game
    when "No"
        return
    end
end


def enter_name(game)
    system "clear"
    prompt = prompt_instance
    prompt.say("You got a high score!")
    name = prompt.ask("Enter your name")
    game.update(user_name: name.upcase)
end

def display_high_scores
    prompt = prompt_instance
    prompt.warn("HIGH SCORES:")
    Game.high_scores.each do |game|
        puts "#{game.user_name} - #{game.score}"
    end
end

def instructions
    prompt = prompt_instance
    system "clear"
    prompt.say("Welcome to")
    prompt.ok("BADGERS AND GYMS")
    sleep(2)
    system "clear"
    prompt.say("HOW TO PLAY:")
    prompt.say("\n")
    prompt.say("Badgers -> %")
    prompt.say("You -> &")
    prompt.say("\n")
    prompt.say("You can escape from the gym through the exit at the top")
    prompt.say("Or you can kill all of the badgers")
    prompt.say("\n")
    prompt.say("Throw grenades to kill the badgers")
    prompt.say("Save your bullets for close-range combat")
    prompt.say("\n")
    prompt.say("The badger apocalypse is upon you")
    prompt.say("\n")
    prompt.select("Godspeed", ["Continue"], help: "Press ENTER to continue")
end