def user_turn(user, game)
    prompt = prompt_instance
    turn_menu_options = determine_turn_menu_options(user)
    prompt.say("Stamina: #{user.stamina}")
    prompt.say("Grenades: #{user.grenade}")
    prompt.say("Bullets: #{user.bullets}")
    user_input = prompt.select("Choose an action", turn_menu_options)
    case user_input
    when "Run"
        direction = user_movement_options_menu(user)
        user_movement(user, 3, direction)
        user.decrease_stamina
        if user.stamina < 3
            user.tired_turn = game.turn
        end
        if user.stamina == 0
            user.tired = true
            user.tired_turn = game.turn
        end
    when "Walk"
        direction = user_movement_options_menu(user)
        user_movement(user, 1, direction)
        # if user.stamina < 3 && user.stamina > 0
        #     user.stamina += 1
        # end
    when "Shoot at badger"
        shoot_at_badger(user)
    when "Throw grenade"
        throw_grenade(user)
    end
end

def determine_turn_menu_options(user)
    options = ["Walk"]
    if user.tired == false
        options << "Run"
    end
    if user.grenade > 0
        options << "Throw grenade"
    end
    if user.bullets > 0
        options << "Shoot at badger"
    end
    options
end

def user_movement_options_menu(user)
    prompt = prompt_instance
    options = user.determine_movement_options
    prompt.select("Select a direction to move", options)
end

def user_movement(user, pace, direction)
    case direction
    when "Up"
        user.move_up(pace)
    when "Left"
        user.move_left(pace)
    when "Right"
        user.move_right(pace)
    when "Down"
        user.move_down(pace)
    end
end

def throw_grenade(user)
    system "clear"
    main_frame(user)
    display_grenade_angles
    prompt = prompt_instance
    angle = prompt.slider("Angle", max: 315, step: 45, default: 0)
    power = prompt.slider("Power", min: 1, max: 3, step: 1, default: 1)
    grenade_coordinates = user.coordinates
    grenade = Grenade.new(angle)
    grenade.start_coordinates(grenade_coordinates)
    grenade_animation(user, grenade, power)
    Badger.dead_badgers.each{|badger| badger.kill}
    user.grenade -= 1
end

#     315  0  45
#        \ | /
#         \|/
#     270 --- 90
#         /|\
#        / | \
#    225  180  135

def display_grenade_angles
    puts <<-ANGLES
        315  0  45
           \\ | /
            \\|/
      270 ------- 90
            /|\\
           / | \\
       225  180  135
    ANGLES
end

def shoot_at_badger(user)
    target = find_best_target(user)
    odds_of_hit = distance_between(user, target).to_i
    random_num = rand(odds_of_hit)
    user.shoot
    if random_num == 0
        target.alive = false
        shot_hit_ani(user, target)
        user.shoot_badger_points
        target.kill
    else
        shot_miss_ani(user, target)
    end
end

def find_best_target(user)
    close_badgers = find_close_badgers(user)
    if close_badgers.length > 1 && (any_badgers_ahead?(user, close_badgers) || any_badgers_lateral?(user, close_badgers))
        badgers_ahead = badgers_ahead(user, close_badgers)
        badgers_lateral = any_badgers_lateral?(user, close_badgers)
        badgers = badgers_ahead + badgers_lateral
    else
        badgers = Badger.current_badgers
    end
    find_closest_badger(user, badgers)
end

def find_closest_badger(user, badger_array)
    badger_array.min do |b_1, b_2|
        distance_between(user, b_1) <=> distance_between(user, b_2)
    end
end

def any_badgers_ahead?(user, close_badgers)
    close_badgers.any? {|badger| y_distance_no_abs(user, badger) > 0}
end

def badgers_ahead(user, close_badgers)
    close_badgers.select {|badger| y_distance_no_abs(user, badger) > 0}
end

def any_badgers_lateral?(user, close_badgers)
    close_badgers.any? {|badger| y_distance_no_abs(user, badger) == 0}
end

def badgers_lateral(user, close_badgers)
    close_badgers.select {|badger| y_distance_no_abs(user, badger) == 0}
end

def y_distance_no_abs(user, badger)
    badger.coordinates[:y_coord] - user.coordinates[:y_coord]
end