# frozen_string_literal: true

class RangeList
  class Error < StandardError; end

  # When ArgumentError raised, please see the document and check your parameters
  class ParametersError < Error; end
end
