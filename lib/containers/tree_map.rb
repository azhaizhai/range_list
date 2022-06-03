# frozen_string_literal: true

require "rbtree"

module Containers
  # rdoc
  #     A Red-Black tree based TreeMap is a data structure that behaves
  #     like a hash and is sorted according to the natural ordering of
  #     its keys.
  class TreeMap
    def initialize
      @tree_map = RBTree.new
    end

    def [](key)
      tree_map[key]
    end

    def []=(key, value)
      tree_map[key] = value
    end

    # remove elements whose key between from_key and to_key
    # @param {Integer} from_key
    # @param {Integer} to_key, can be nil
    # @return {void}
    def remove(from_key, to_key = nil)
      if to_key.nil?
        tree_map.delete(from_key)
      else
        keys = []
        tree_map.bound(from_key, to_key) do |key, _value|
          keys << key
        end

        keys.each { |k| tree_map.delete(k) }
      end
      nil
    end

    # get element from tree_map whose key is lower than or equal to param
    # @param {Integer} key
    # @return {Integer[]}
    def lower_entry(key)
      tree_map.upper_bound(key)
    end

    def to_a
      tree_map.to_a
    end

    private

    attr_accessor :tree_map
  end
end
