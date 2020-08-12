def gameplay(user, game, num_badgers)
    Badger.generate_badgers(num_badgers)
    user.start(num_badgers)
    user.set_points
    game.start
    intro(num_badgers)
    while user.alive == true do
        game.inc_turn
        turn(user, game)
        user_win?(user)
        if user.win == true || Badger.current_badgers.empty? == true
            system "clear"
            win_frame(user)
            sleep(1.5)
            break
        end
        Badger.make_moves(user)
        user_dead?(user)
        if user.alive == false
            system "clear"
            killed_by_badger_frame_message(user)
            sleep(1.5)
        end
        if user.lights == false
            turn_lights_off?(user, game)
        end
        if user.lights == false && game.lights_off_over? == true
            user.lights = true
            game.lights_off_turn = nil
        end
        if user.tired == true && user.recharge_stamina?(game) == true
            user.tired = false
            user.tired_turn = nil
            user.restore_stamina
        elsif user.stamina < 3 && user.recharge_stamina?(game) == true
            user.tired_turn = nil
            user.restore_stamina
        end
    end
    system "clear"
    prompt = prompt_instance
    if user.win == true
        user.survival_points(num_badgers)
        prompt.say("You escaped the gym!")
    else
        prompt.error("Game over!")
        game.lost = true
    end
    running_score = game.score
    game.score = running_score + user.points
    prompt.say("Score: #{game.score}")
    prompt.select("Press Enter to continue", ["Continue"], help: "")
end

def intro(num_badgers)
    system "clear"
    prompt = prompt_instance
    prompt.ok("BADGERS AND GYMS")
    prompt.say("LEVEL #{num_badgers - 1}")
    prompt.say("\n")
    prompt.say("\n")
    display_high_scores
    sleep(3)
    system "clear"
    prompt.say("You find yourself in a gym, but you're not alone...")
    sleep(1.5)
    prompt.say("...inside this gym there are...")
    sleep(1.5)
    prompt.say("      #{Badger.current_badgers.length} BADGERS!")
    sleep(1.5)
end



def turn(user, game)
    if find_close_badgers(user).empty? == false && user.lights == false
        system "clear"
        prompt = prompt_instance
        if find_close_badgers(user).length == 1
            prompt.say("A badger is near")
        else
            prompt.say("There are badgers approaching")
        end
        sleep(1.5)
    end
    system "clear"
    main_frame(user)
    user_turn(user, game)
end

def user_win?(user)
    if user.coordinates[:y_coord] == 0 && [20, 21, 22, 23].include?(user.coordinates[:x_coord]) == true
        user.win = true
    elsif Badger.current_badgers.empty? == true
        user.win = true
    end
end

def turn_lights_off?(user, game)
    odds = rand(10)
    if odds == 0
        user.lights = false
        game.set_lights_off_turn
    end
end

def user_dead?(user)
    # if Badger.current_badgers.any? {|badger| distance_between(user, badger) <= 2} == true
    #     system "clear"
    #     main_frame(user)
    #     sleep(1)
    #     killer_badger = Badger.current_badgers.find {|badger| distance_between(user, badger) <= 2}
    #     y = user.coordinates[:y_coord]
    #     x = user.coordinates[:x_coord]
    #     killer_badger.coordinates[:y_coord] = y
    #     killer_badger.coordinates[:x_coord] = x
    #     killer_badger.killer = true
    #     user.alive = false
    # end
    if Badger.current_badgers_coordinates.include?(user.coordinates)
        user.alive = false
    end
end

def find_close_badgers(user)
    Badger.current_badgers.select {|badger| distance_between(user, badger) < 4}
end

def distance_between(user, badger)
    y_length = y_distance_between(user, badger).abs()
    x_length = x_distance_between(user, badger).abs()
    Math.sqrt(y_length**2 + x_length**2)
end

def y_distance_between(user, badger)
    (badger.coordinates[:y_coord] - user.coordinates[:y_coord])
end

def x_distance_between(user, badger)
    (badger.coordinates[:x_coord] - user.coordinates[:x_coord]) * 2
end