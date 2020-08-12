require_relative "movement.rb"

class Badger
    include Movement
    attr_accessor :name, :alive, :pace, :killer
    @@all = []

    def initialize(name)
        self.name = name
        @@all << self
    end

    def self.all
        @@all
    end

    def self.generate_badgers(num_badgers)
        @@current_badgers = self.all.sample(num_badgers)
        @@current_badgers.each do |bad|
            bad.start_coordinates
            bad.pace = 2
            bad.alive = true
        end
    end

    def self.current_badgers
        @@current_badgers
    end

    def self.clear_current_badgers
        @@current_badgers.clear
    end

    def self.make_moves(user)
        self.current_badgers.each do |badger|
            if self.current_badgers.any? {|badger| distance_between(user, badger) < 4} == true
                killer_badger = self.current_badgers.find {|badger| distance_between(user, badger) < 4}
                y = user.coordinates[:y_coord]
                x = user.coordinates[:x_coord]
                killer_badger.coordinates[:y_coord] = y
                killer_badger.coordinates[:x_coord] = x
                killer_badger.killer = true
            else
                badger.move(user)
                if badger.coordinates == user.coordinates
                    badger.killer = true
                end
            end
        end
        
    end

    #     315  0  45
    #        \ | /
    #         \|/
    #     270 --- 90
    #         /|\
    #        / | \
    #    225  180  135

    # y positive = below user
    # y negative = above user

    # x positve = to the right of user
    # x negative = to the left of user

    def move(user)
        y_distance = y_distance_between(user, self)
        x_distance = x_distance_between(user, self)
        diagonal_pace = self.pace

        if y_distance == 0
            if x_distance > 0
                self.move_left(self.pace)
            else
                self.move_right(self.pace)
            end
        elsif x_distance == 0
            if y_distance > 0
                self.move_up(self.pace)
            else
                self.move_down(self.pace)
            end
        # above, left
        elsif y_distance < 0 && x_distance < 0
            diagonal_pace.times do
                self.move_135
            end
        # above, right
        elsif y_distance < 0 && x_distance > 0
            diagonal_pace.times do
                self.move_225
            end
        # below, left
        elsif y_distance > 0 && x_distance < 0
            diagonal_pace.times do
                self.move_45
            end
        # below, right
        else
            diagonal_pace.times do
                self.move_315
            end
        end
    end

    def self.current_badgers_coordinates
        self.current_badgers.collect {|badger| badger.coordinates}
    end

    def self.dead_badgers
        self.current_badgers.select {|badger| badger.alive == false}
    end

    def kill
        @@current_badgers.delete(self)
    end

    def start_coordinates
        y = rand(12)
        x = rand(1..40)
        self.coordinates = {y_coord: y, x_coord: x}
    end

    def self.kill_badgers_in_blast(grenade)
        # binding.pry
        self.current_badgers.each do |badger|
            if grenade.third_blast_coordinates.include?(badger.coordinates) == true || grenade.second_blast_coordinates.include?(badger.coordinates) == true
                badger.alive = false
            end
        end
    end
end