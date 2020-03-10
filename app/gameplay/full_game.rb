def full_game
    prompt = prompt_instance

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