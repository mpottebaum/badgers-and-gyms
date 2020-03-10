require_relative "movement.rb"

class Grenade
    include Movement
    attr_accessor :coordinates, :second_blast_coordinates, :third_blast_coordinates, :third_no_invisible_coords, :angle
#     315  0  45
#        \ | /
#         \|/
#     270 --- 90
#         /|\
#        / | \
#    225  180  135
    def initialize(angle)
        @angle = angle
    end

    def start_coordinates(user_coordinates)
        y = user_coordinates[:y_coord]
        x = user_coordinates[:x_coord]
        if [315, 0, 45].include?(self.angle) == true
            y -= 1
        elsif [225, 180, 135].include?(self.angle) == true
            y += 1
        elsif self.angle == 270
            x -= 1
        else
            x += 1
        end
        self.coordinates = {y_coord: y, x_coord: x}
    end

    def set_second_blast_coordinates
        y = self.coordinates[:y_coord]
        x = self.coordinates[:x_coord]
        y_coords = [y, (y + 1), (y - 1)]
        x_coords_1 = [x, (x + 1), (x - 1)]
        x_coords_2 = [(x + 2), (x - 2)]
        second = []
        x_coords_1.each do |x_c|
            y_coords.each do |y_c|
                second << {y_coord: y_c, x_coord: x_c}
            end
        end
        x_coords_2.each do |x_c|
            second << {y_coord: y, x_coord: x_c}
        end
        self.second_blast_coordinates = second.reject do |coords|
            coords[:y_coord] < 0 || coords[:y_coord] > 24 || coords[:x_coord] < 1 || coords[:x_coord] > 40
        end
    end

    def set_third_blast_coordinates
        y = self.coordinates[:y_coord]
        x = self.coordinates[:x_coord]
        y_coords_2 = [(y + 1), (y - 1)]
        y_coords_3 = [(y + 2), (y - 2)]
        x_coords_1 = [(x + 3), (x - 3)]
        x_coords_2 = [(x + 2), (x - 2)]
        x_coords_3 = [x, (x + 1), (x - 1)]
        third = []
        x_coords_1.each do |x_c|
            third << {y_coord: y, x_coord: x_c}
        end
        x_coords_2.each do |x_c|
            y_coords_2.each do |y_c|
                third << {y_coord: y_c, x_coord: x_c}
            end
        end
        x_coords_3.each do |x_c|
            y_coords_3.each do |y_c|
                third << {y_coord: y_c, x_coord: x_c}
            end
        end
        x_coords_1.each do |x_c|
            y_coords_3.each do |y_c|
                third << {y_coord: y_c, x_coord: x_c}
            end
        end
        # excluded from display
        # [(y + 1), (y - 1)] && [(x + 3), (x - 3)]
        # [(y + 2), (y - 2)] && [(x + 2), (x - 2)]
        x_coords_1.each do |x_c|
            y_coords_2.each do |y_c|
                third << {y_coord: y_c, x_coord: x_c}
            end
        end

        x_coords_2.each do |x_c|
            y_coords_3.each do |y_c|
                third << {y_coord: y_c, x_coord: x_c}
            end
        end


        minus_out_of_bounds = third.reject do |coords|
            coords[:y_coord] < 0 || coords[:y_coord] > 24 || coords[:x_coord] < 1 || coords[:x_coord] > 40
        end

        self.third_blast_coordinates = minus_out_of_bounds
        
        exclude_invisible = minus_out_of_bounds.reject do |coords|
            [(y + 1), (y - 1)].include?(coords[:y_coord]) == true && [(x + 3), (x - 3)].include?(coords[:x_coord]) == true ||
            [(y + 2), (y - 2)].include?(coords[:y_coord]) == true && [(x + 2), (x - 2)].include?(coords[:x_coord]) == true
        end

        self.third_no_invisible_coords = exclude_invisible
    end

    

    # def move_45
    #     self.move_up(1)
    #     self.move_right(0.5)
    # end

    # def move_135
    #     self.move_down(1)
    #     self.move_right(0.5)
    # end

    # def move_225
    #     self.move_down(1)
    #     self.move_left(0.5)
    # end

    # def move_315
    #     self.move_up(1)
    #     self.move_left(0.5)
    # end

    def check_angle_and_adjust
        case self.angle
        when 0
            if self.coordinates[:y_coord] == 0
                self.angle = 180
            end
        when 45
            if self.coordinates[:y_coord] == 0 && grenade.coordinates[:x_coord] == 40
                self.angle = 225
            elsif self.coordinates[:y_coord] == 0
                self.angle = 135
            elsif self.coordinates[:x_coord] == 40
                self.angle = 315
            end
        when 90
            if self.coordinates[:x_coord] == 40
                self.angle = 270
            end
        when 135
            if self.coordinates[:y_coord] == 24 && grenade.coordinates[:x_coord] == 40
                self.angle = 315
            elsif self.coordinates[:y_coord] == 24
                self.angle = 45
            elsif self.coordinates[:x_coord] == 40
                self.angle = 225
            end
        when 180
            if self.coordinates[:y_coord] == 24
                self.angle = 0
            end
        when 225
            if self.coordinates[:y_coord] == 24 && grenade.coordinates[:x_coord] == 1
                self.angle = 45
            elsif self.coordinates[:y_coord] == 24
                self.angle = 315
            elsif self.coordinates[:x_coord] == 1
                self.angle = 135
            end
        when 270
            if self.coordinates[:x_coord] < 3
                self.angle = 90
            end
        when 315
            if self.coordinates[:y_coord] == 0 && grenade.coordinates[:x_coord] == 1
                self.angle = 135
            elsif self.coordinates[:y_coord] == 0
                self.angle = 225
            elsif self.coordinates[:x_coord] == 1
                self.angle = 45
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

#                    * *** *
#         ***         *****
# *      *****       *******
#         ***         *****
#                    * *** *


#                    * *** *
#         ***         *xxx*
# *      *****       *xxxxx*
#         ***         *xxx*
#                    * *** *