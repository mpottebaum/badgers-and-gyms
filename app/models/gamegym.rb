class GameGym
    attr_accessor :hash

    def initialize
        self.hash = empty_gym_hash
    end

    def place_players(user, badger_array)
        self.hash[user.coordinates[:y_coord]][user.coordinates[:x_coord]] = "&"
        badger_array.each do |badger|
            self.hash[badger.coordinates[:y_coord]][badger.coordinates[:x_coord]] = "%"
        end
    end

    def place_badgers(badger_array)
        badger_array.each do |badger|
            self.hash[badger.coordinates[:y_coord]][badger.coordinates[:x_coord]] = "%"
        end
    end

    def place_shot(user, target)
        y_distance = y_distance_between(user, target)
        x_distance = x_distance_between(user, target)
        if y_distance > 0
            y_coord = user.coordinates[:y_coord] + 1
        else
            y_coord = user.coordinates[:y_coord] - 1
        end
        self.hash[y_coord][user.coordinates[:x_coord]] = "*"
    end

    def place_players_with_dead(user, badger_array)
        if user.alive == false
            self.hash[user.coordinates[:y_coord]][user.coordinates[:x_coord]] = "#"
        else
            self.hash[user.coordinates[:y_coord]][user.coordinates[:x_coord]] = "&"
        end
        badger_array.each do |badger|
            if badger.alive == false
                self.hash[badger.coordinates[:y_coord]][badger.coordinates[:x_coord]] = "#"
            else
                self.hash[badger.coordinates[:y_coord]][badger.coordinates[:x_coord]] = "%"
            end
        end
    end
    
    def place_grenade(grenade)
        self.hash[grenade.coordinates[:y_coord]][grenade.coordinates[:x_coord]] = "@"
    end
    
    def place_first_blast(grenade)
        self.hash[grenade.coordinates[:y_coord]][grenade.coordinates[:x_coord]] = "*"
    end
    
    def place_second_blast(grenade)
        grenade.second_blast_coordinates.each do |coords|
            self.hash[coords[:y_coord]][coords[:x_coord]] = "*"
        end
    end
    
    # [(y + 1), (y - 1)] && [(x + 3), (x - 3)]
    def place_third_blast(grenade)
        self.place_second_blast(grenade)
        grenade.third_no_invisible_coords.each do |coords|
            self.hash[coords[:y_coord]][coords[:x_coord]] = "*"
        end
    end
end