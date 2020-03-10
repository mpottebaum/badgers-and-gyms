def main_frame(user)
    if user.lights == true
        gym = GameGym.new
        gym.place_players(user, Badger.current_badgers)
        display_gym(gym.hash)
    else
        display_dark_gym
    end
end

def grenade_frame(user, grenade)
    if user.lights == true
        gym = GameGym.new
        gym.place_players(user, Badger.current_badgers)
        gym.place_grenade(grenade)
        display_gym(gym.hash)
    else
        display_dark_gym
    end
end

def grenade_first_blast_frame(user, grenade)
    gym = GameGym.new
    gym.place_players(user, Badger.current_badgers)
    gym.place_first_blast(grenade)
    display_gym(gym.hash)
end

def grenade_second_blast_frame(user, grenade)
    gym = GameGym.new
    gym.place_players(user, Badger.current_badgers)
    grenade.set_second_blast_coordinates
    gym.place_second_blast(grenade)
    display_gym(gym.hash)
end

def grenade_third_blast_frame(user, grenade)
    gym = GameGym.new
    gym.place_players(user, Badger.current_badgers)
    grenade.set_third_blast_coordinates
    gym.place_third_blast(grenade)
    display_gym(gym.hash)
end

def grenade_miss_frame_message(user)
    prompt = prompt_instance
    if user.lights == true
        gym = GameGym.new
        gym.place_players(user, Badger.current_badgers)
        display_gym(gym.hash)
    else
        display_dark_gym
    end
    prompt.warn("You missed")
end

def grenade_kill_frame_message(user)
    prompt = prompt_instance
    if user.lights == true
        gym = GameGym.new
        gym.place_players_with_dead(user, Badger.current_badgers)
        display_gym(gym.hash)
    else
        display_dark_gym
    end
    if Badger.dead_badgers.length > 1
        prompt.error("You killed #{Badger.dead_badgers.length} badgers!")
    else
        prompt.error("You killed the badger #{Badger.dead_badgers.first.name}")
    end
end

def grenade_suicide_frame_message(user)
    prompt = prompt_instance
    if user.lights == true
        gym = GameGym.new
        gym.place_players_with_dead(user, Badger.current_badgers)
        display_gym(gym.hash)
    else
        display_dark_gym
    end
    prompt.error("You blew yourself up!")
end

def shot_frame(user, target)
    gym = GameGym.new
    gym.place_players(user, Badger.current_badgers)
    gym.place_shot(user, target)
    display_gym(gym.hash)
end

def kill_frame(user)
    if user.lights == true
        gym = GameGym.new
        gym.place_players_with_dead(user, Badger.current_badgers)
        display_gym(gym.hash)
    else
        display_dark_gym
    end
end

def kill_frame_message(user)
    prompt = prompt_instance
    dead_badger = Badger.current_badgers.find {|badger| badger.alive == false}
    if user.lights == true
        gym = GameGym.new
        gym.place_players_with_dead(user, Badger.current_badgers)
        display_gym(gym.hash)
    else
        display_dark_gym
    end
    prompt.error("You killed the badger #{dead_badger.name}")
end

def miss_message_frame(user)
    prompt = prompt_instance
    if user.lights == true
        gym = GameGym.new
        gym.place_players(user, Badger.current_badgers)
        display_gym(gym.hash)
    else
        display_dark_gym
    end
    prompt.error("You missed!")
end

def killed_by_badger_frame_message(user)
    prompt = prompt_instance
    if user.lights == true
        gym = GameGym.new
        gym.place_players_with_dead(user, Badger.current_badgers)
        display_gym(gym.hash)
    else
        display_dark_gym
    end
    killer_badger = Badger.current_badgers.find {|badger| badger.killer == true}
    prompt.error("The badger #{killer_badger.name} killed you")
end

def win_frame(user)
    gym = GameGym.new
    gym.place_badgers(Badger.current_badgers)
    display_win_gym(user, gym.hash)
end