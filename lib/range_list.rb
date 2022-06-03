# frozen_string_literal: true

require_relative "range_list/version"
require_relative "containers/tree_map"
require_relative "range_list/errors"

# rdoc
#     A pair of integers define a range, for example: [1, 5). This range includes
#     integers: 1, 2, 3, and 4.
#     A range list is an aggregate of these ranges: [1, 5), [10, 11), [100, 201)
#     A TreeMap based RangeList is a data structure that behaves like a range list
class RangeList
  def initialize
    @range_list = Containers::TreeMap.new
  end

  # Add range into current range list
  # @param {Integer[]} range, has 2 elements
  # @return {Boolean}
  # @raise {ParametersError}
  def add(range)
    validate_range!(range)
    return false unless can_use?(range)

    # get real key and value that will be added
    key = calculate_data_for_add(range[0], 0)
    value = calculate_data_for_add(range[1], 1)

    # remove ranges which key between `key` and `value``
    range_list.remove(key + 1, value)

    # add new range or update range list
    range_list[key] = value

    true
  end

  # Print current range list.
  # @return {void}
  def print
    puts range_list.to_a.map { |key, value| "[#{key}, #{value})" }.join(" ")
    nil
  end

  # Remove range from current range list
  # @param {Integer[]} range, has 2 elements
  # @return {Boolean}
  # @raise {ParametersError}
  def remove(range)
    validate_range!(range)
    return false unless can_use?(range)

    # insert or update range list with `range` data`
    [1, 0].each { |i| change_data_for_remove(range[i], i) }

    # remove ranges which key between `range` data
    if range[0] == range[1] - 1
      range_list.remove(range[0])
    else
      range_list.remove(range[0], range[1] - 1)
    end

    true
  end

  private

  attr_accessor :range_list

  def validate_range!(range)
    raise ParametersError, "`range` should be `Array` type." unless range.is_a?(Array)
    raise ParametersError, "`range` size should be equal to 2." unless range.size == 2
    raise ParametersError, "Elements in `range` should be `Integer`." unless range.all? { |item| item.is_a?(Integer) }
  end

  # check if `range`` elemetns order by asc
  def can_use?(range)
    range[0] < range[1]
  end

  def calculate_data_for_add(num, index)
    lower_entry = range_list.lower_entry(num)

    if lower_entry.nil? || lower_entry[1] < num
      num
    else
      lower_entry[index]
    end
  end

  def change_data_for_remove(num, index)
    lower_entry = range_list.lower_entry(num - 1)
    if !lower_entry.nil? && lower_entry[1] > num
      case index
      when 0
        range_list[lower_entry[index]] = num
      when 1
        range_list[num] = lower_entry[index]
      end
    end
    nil
  end
end
