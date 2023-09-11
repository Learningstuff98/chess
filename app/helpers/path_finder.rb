module PathFinder
  def self.range(value, destination_value)
    if destination_value > value
      ((value + 1)..(destination_value - 1)).to_a
    else
      ((destination_value + 1)..(value - 1)).to_a
    end
  end

  def self.horizontal_path(x, y, destination_x)
    range(x, destination_x).map do |x_value|
      [x_value, y]
    end
  end

  def self.verticle_path(x, y, destination_y)
    range(y, destination_y).map do |y_value|
      [x, y_value]
    end
  end

  def self.diagonal_path(x, y, destination_x, destination_y)
    y_values = diagonal_y_values(x, y, destination_x, destination_y)
    range(x, destination_x).map.with_index do |x_value, index|
      [x_value, y_values[index]]
    end
  end

  def self.diagonal_y_values(x, y, destination_x, destination_y)
    y_values = range(y, destination_y)
    if destination_x > x
      y_values = y_values.reverse if destination_y < y
    elsif destination_y > y
      y_values = y_values.reverse
    end
    y_values
  end
end

# need the following functions:

#   range DONE
#   horizontal_path DONE
#   verticle_path DONE
#   diagonal_path DONE
#   diagonal_y_values DONE
#   path_clear?
