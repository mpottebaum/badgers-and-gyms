require_relative "movement.rb"

class User
    include Movement
    attr_accessor :bullets, :grenade, :stamina, :tired, :tired_turn, :alive, :lights, :points, :win

    def start(num_badgers)
        self.coordinates = {y_coord: 24, x_coord: 20}
        self.bullets = Math.sqrt(num_badgers).ceil
        self.grenade = (Math.log(num_badgers).ceil) + 2
        self.stamina = 3
        self.tired = false
        self.alive = true
        self.lights = true
        self.win = false
        @@user = self
    end

    def set_points
        self.points = 0
    end

    def self.user
        @@user
    end

    def lights_on
        self.lights = true
    end

    def lights_off
        self.lights = false
    end

    def decrease_stamina
        self.stamina -= 1
    end

    def restore_stamina
        self.stamina = 3
    end

    def recharge_stamina?(game)
        if self.tired_turn == nil
            return false
        end
        if (game.turn - self.tired_turn) == 3
            return true
        else
            return false
        end
    end

    def shoot
        self.bullets -= 1
    end

    def kill_if_in_blast(grenade)
        if grenade.third_blast_coordinates.include?(self.coordinates) == true
            self.alive == false
        end
    end

    def shoot_badger_points
        self.points += 300
    end

    def grenade_kill_badger_points(num_badgers)
        self.points += (300 * (num_badgers**num_badgers))
    end

    def survival_points(num_badgers)
        self.points += (1000 * num_badgers)
    end
end