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
end

# need the following functions:

#   horizontal_or_verticle_path this one feels redundant
#   range DONE
#   horizontal_path DONE
#   verticle_path DONE
#   diagonal_path
#   diagonal_y_values
#   path_clear?
