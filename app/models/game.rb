class Game < ActiveRecord::Base
    attr_accessor :turn, :lights_off_turn, :lost

    def start
        self.turn = 0
        @@current = self
    end

    def self.current
        @@current
    end

    def inc_turn
        self.turn += 1
    end

    def set_lights_off_turn
        self.lights_on_turn = self.turn
    end

    def lights_off_over?
        if self.lights_off_turn == nil
            return false
        end
        if (self.turn - self.lights_off_turn) == 3
            return true
        else
            return false
        end
    end

    def self.high_scores
        if self.all.length < 2
            self.all
        else
            self.all.max(10) {|g_1, g_2| g_1.score <=> g_2.score}
        end
    end
end