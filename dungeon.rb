#!/usr/bin/env ruby

class Dungeon
  require 'byebug'
  attr_accessor :player

  def initialize(player)
    @player = player
    @rooms = {}
  end

  def add_room(reference, name, description, connections)
    @rooms[reference] = Room.new(reference, name, description, connections)
  end

  def start(location)
    puts "started in location #{location}"
    @player.location = location
    show_current_description
  end

  def show_current_description
    #byebug
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(reference)
    #byebug
    @rooms[reference]
  end

  def find_room_in_direction(direction)
    #byebug
    current_room = find_room_in_dungeon(@player.location)
    puts current_room.connections
    if current_room.connections.include?(direction)
      current_room.connections[direction]
    else

      raise "No room found in #{direction} for #{current_room.name}"
    end
  end

  def go(direction)
    #byebug
    puts "You go " + direction.to_s
    @player.location = find_room_in_direction(direction)
    show_current_description
  end
end


class Player
  attr_accessor :name, :location
  def initialize(name)
    @name = name
  end
end

class Room
  attr_accessor :reference, :name, :description, :connections

  def initialize(reference, name, description, connections)
    @reference = reference
    @name = name
    @description = description
    @connections = connections
  end

  def full_description
    puts "name of room and description"
    @name + "\n\nYou are in " + @description
  end
end


me = Player.new("Fred Bloggs")
my_dungeon = Dungeon.new(me)


# Add rooms to the dungeon
my_dungeon.add_room(:largecave,
                    "Large Cave",
                    "a large cavernous cave",
                    { :west => :smallcave })

my_dungeon.add_room(:smallcave,
                    "Small Cave",
                    "a small, claustrophobic cave",
                    { :east => :largecave })
# Start the dungeon by placing the player in the large cave

my_dungeon.start(:largecave)

puts  "Before calling go: #{me.location}"
direction = ""

puts "direction: #{direction.to_sym}"
while (direction != 'e' || direction != 'exit')
    puts "Direction to go [east | west | south | north | exit]: \n"
    direction = gets.chomp
    if direction == 'e' || direction == 'exit'
      exit 1
    else
      my_dungeon.go(direction.to_sym)
    end
end

