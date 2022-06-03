# RangeList

RangeList is a library which accomplish a range list structure with basic methods

A pair of integers define a range, for example: [1, 5). This range includes integers: 1, 2, 3, and 4.
A range list is an aggregate of these ranges: [1, 5), [10, 11), [100, 201).
A TreeMap based RangeList is a data structure that behaves like a range list.

## Usage

```ruby
rl = RangeList.new
rl.add([1, 5])
rl.print # => [1, 5)
rl.add([10, 20])
rl.print # => [1, 5) [10, 20)

rl.add([20, 20])
rl.print # => [1, 5) [10, 20)
rl.add([20, 21])
rl.print # => [1, 5) [10, 21)
rl.add([2, 4])
rl.print # => [1, 5) [10, 21)
rl.add([3, 8])
rl.print # => [1, 8) [10, 21)

rl.remove([10, 10])
rl.print # => [1, 8) [10, 21)
rl.remove([10, 11])
rl.print # => [1, 8) [11, 21)
rl.remove([15, 17])
rl.print # => [1, 8) [11, 15) [17, 21)
rl.remove([3, 19])
rl.print # => [1, 3) [19, 21)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://jihulab.com/jayyang/range_list.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
