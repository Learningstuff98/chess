module PathFinder
  def self.range(value, destination_value)
    if destination_value > value
      ((value + 1)..(destination_value - 1)).to_a
    else
      ((destination_value + 1)..(value - 1)).to_a
    end
  end
end

# need the following functions:

#   horizontal_or_verticle_path
#   range DONE
#   horizontal_path
#   verticle_path
#   diagonal_path
#   diagonal_y_values
#   path_clear?
