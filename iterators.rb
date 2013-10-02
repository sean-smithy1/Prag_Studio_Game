#!/bin/ruby
def five_times(times)
  1.upto(times) do |count|
    yield count
  end
end

five_times(20) do |n|
  puts "#{n} situps"
  puts "#{n} pushups"
  puts "#{n} chinups"
end
