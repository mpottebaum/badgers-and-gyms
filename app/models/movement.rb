module Movement
    # coordinates: {y-coord: 0, x-coord: 0}
    attr_accessor :coordinates

    def move_up(num_spaces)
        if (self.coordinates[:y_coord] - num_spaces) < 0
            self.coordinates[:y_coord] = 0
        else
            self.coordinates[:y_coord] -= num_spaces
        end
    end
    
    def move_down(num_spaces)
        if (self.coordinates[:y_coord] + num_spaces) > 24
            self.coordinates[:y_coord] = 24
        else
            self.coordinates[:y_coord] += num_spaces
        end
    end

    def move_left(num_spaces)
        if (self.coordinates[:x_coord] - (num_spaces * 2)) < 1
            self.coordinates[:x_coord] = 1
        else
            self.coordinates[:x_coord] -= (num_spaces * 2).to_i
        end
    end

    def move_right(num_spaces)
        if (self.coordinates[:x_coord] + (num_spaces * 2)) > 40
            self.coordinates[:x_coord] = 40
        else
            self.coordinates[:x_coord] += (num_spaces * 2).to_i
        end
    end

    def move_45
        self.move_up(1)
        self.move_right(0.5)
    end

    def move_135
        self.move_down(1)
        self.move_right(0.5)
    end

    def move_225
        self.move_down(1)
        self.move_left(0.5)
    end

    def move_315
        self.move_up(1)
        self.move_left(0.5)
    end

    def determine_movement_options
        options = []
        if self.coordinates[:y_coord] > 0
            options << "Up"
        end
        if self.coordinates[:x_coord] > 1
            options << "Left"
        end
        if self.coordinates[:x_coord] < 40
            options << "Right"
        end
        if self.coordinates[:y_coord] < 24
            options << "Down"
        end
        options
    end
end