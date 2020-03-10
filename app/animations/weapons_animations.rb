def shot_hit_ani(user, target)
    system "clear"
    main_frame(user)
    sleep(1.5)
    system "clear"
    shot_frame(user, target)
    sleep(1.5)
    system "clear"
    kill_frame(user)
    sleep(1.5)
    system "clear"
    kill_frame_message(user)
    sleep(1.5)
end

def shot_miss_ani(user, target)
    system "clear"
    main_frame(user)
    sleep(1.5)
    system "clear"
    shot_frame(user, target)
    sleep(1.5)
    system "clear"
    main_frame(user)
    sleep(1.5)
    system "clear"
    miss_message_frame(user)
    sleep(1.5)
end

def grenade_animation(user, grenade, power)
    system "clear"
    grenade_frame(user, grenade)
    sleep(1)
    system "clear"
    grenade_movement(grenade, power)
    grenade_frame(user, grenade)
    sleep(0.75)
    system "clear"
    grenade_movement(grenade, power)
    grenade_frame(user, grenade)
    sleep(0.5)
    system "clear"
    grenade_movement(grenade, power)
    grenade_frame(user, grenade)
    sleep(0.5)
    system "clear"
    grenade_first_blast_frame(user, grenade)
    sleep(0.5)
    system "clear"
    grenade_second_blast_frame(user, grenade)
    sleep(1)
    system "clear"
    grenade_third_blast_frame(user, grenade)
    sleep(1)
    system "clear"
    kill_players_in_blast_radius(user, grenade)
    if user.alive == false
        grenade_suicide_frame_message(user)
    elsif Badger.current_badgers.any? {|badger| badger.alive == false} == true
        grenade_kill_frame_message(user)
        dead_badgers = Badger.current_badgers.select {|badger| badger.alive == false}
        user.grenade_kill_badger_points(dead_badgers.length)
        dead_badgers.each {|badger| badger.kill}
    else
        grenade_miss_frame_message(user)
    end
    sleep(1.5)
end

def grenade_movement(grenade, power)
    power.times do
        grenade_single_movement(grenade)
    end
end
#     315  0  45
#        \ | /
#         \|/
#     270 --- 90
#         /|\
#        / | \
#    225  180  135
def grenade_single_movement(grenade)
    # binding.pry
    grenade.check_angle_and_adjust
    case grenade.angle
    when 0
        grenade.move_up(1)
    when 45
        grenade.move_45
    when 90
        grenade.move_right(1)
    when 135
        grenade.move_135
    when 180
        grenade.move_down(1)
    when 225
        grenade.move_225
    when 270
        grenade.move_left(1)
    when 315
        grenade.move_315
    end
    # binding.pry
end

def kill_players_in_blast_radius(user, grenade)
    Badger.kill_badgers_in_blast(grenade)
    user.kill_if_in_blast(grenade)
end