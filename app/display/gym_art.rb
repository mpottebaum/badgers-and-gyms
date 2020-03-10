#  ----------------------------------------     # height: 25
# |             |          |               |    # width: 42, playable width: 40
# |             |          |               |    
# |             |          |               |    # pipes - 14, 25 horizontal
# |             |  .-""-.  |               |    # circle start - 3 vertical
# |             |/`      `\|               |    # circle end - 8 v
# |             ;          ;               |
# |             ;          ;               |    
# |              \        /                |    % - badger
# |               `'-..-'`                 |    & - person
# |                                        |
# |          The lights are off            |
# |                                        |
# |----------------------------------------|
# |                                        |
# |                                        |
# |                                        |
# |                .-""-.                  |    # circle start - 16
# |              /`      `\                |    # circle end - 20
# |             ;          ;               |
# |             ;          ;               |
# |             |\        /|               |
# |             | `'-..-'` |               |
# |             |          |               |
# |             |          |               |
# |             |          |               |
#  ----------------------------------------


def display_gym(gym_hash)
    puts " ------------------    ------------------ "
    gym_hash.each_value {|row| puts row.join}
    puts " ---------------------------------------- "
end

def display_win_gym(user, gym_hash)
    top = " ------------------    ------------------ ".split("")
    if user.coordinates[:x_coord] <= 23 && user.coordinates[:x_coord] >= 20
        top[user.coordinates[:x_coord]] = "&"
    else
        top[21] = "&"
    end
    puts top.join
    gym_hash.each_value {|row| puts row.join}
    puts " ---------------------------------------- "
end

def empty_gym_hash
    key_pipes_1 = "|             |          |               |".split("")
    key_pipes_2 = "|             |          |               |".split("")
    key_pipes_3 = "|             |          |               |".split("")
    top_circle_one = "|             |  .-\"\"-.  |               |".split("")
    first_arc_circle_one = "|             |/`      `\\|               |".split("")
    first_middle_circle_one = "|             ;          ;               |".split("")
    second_middle_circle_one = "|             ;          ;               |".split("")
    second_arc_circle_one = "|              \\        /                |".split("")
    bottom_circle_one = "|               `'-..-'`                 |".split("")
    just_pipes_1 = "|                                        |".split("")
    just_pipes_2 = "|                                        |".split("")
    just_pipes_3 = "|                                        |".split("")
    mid_court = "|----------------------------------------|".split("")
    just_pipes_4 = "|                                        |".split("")
    just_pipes_5 = "|                                        |".split("")
    just_pipes_6 = "|                                        |".split("")
    top_circle_two = "|                .-\"\"-.                  |".split("")
    first_arc_circle_two = "|              /`      `\\                |".split("")
    first_middle_circle_two = "|             ;          ;               |".split("")
    second_middle_circle_two = "|             ;          ;               |".split("")
    second_arc_circle_two = "|             |\\        /|               |".split("")
    bottom_circle_two = "|             | `'-..-'` |               |".split("")
    key_pipes_4 = "|             |          |               |".split("")
    key_pipes_5 = "|             |          |               |".split("")
    key_pipes_6 = "|             |          |               |".split("")


    {
        0 => key_pipes_1,
        1 => key_pipes_2,
        2 => key_pipes_3,
        3 => top_circle_one,
        4 => first_arc_circle_one,
        5 => first_middle_circle_one,
        6 => second_middle_circle_one,
        7 => second_arc_circle_one,
        8 => bottom_circle_one,
        9 => just_pipes_1,
        10 => just_pipes_2,
        11 => just_pipes_3,
        12 => mid_court,
        13 => just_pipes_4,
        14 => just_pipes_5,
        15 => just_pipes_6,
        16 => top_circle_two,
        17 => first_arc_circle_two,
        18 => first_middle_circle_two,
        19 => second_middle_circle_two,
        20 => second_arc_circle_two,
        21 => bottom_circle_two,
        22 => key_pipes_4,
        23 => key_pipes_5,
        24 => key_pipes_6,
    }
end