require 'pry'

class Bot
  attr_accessor :x, :y, :facing
  FS = %w(NORTH EAST SOUTH WEST)

  def place(x, y, facing)
    !(valid_position?(x, y) && valid_direction?(facing)) and return
    @x, @y, @facing = x, y, facing
  end

  def move
    case facing
    when 'NORTH'
      @y += 1 if valid_position?(@x, @y + 1)
    when 'SOUTH'
      @y -= 1 if valid_position?(@x, @y - 1)
    when 'EAST'
      @x += 1 if valid_position?(@x + 1, @y)
    when 'WEST'
      @x -= 1 if valid_position?(@x - 1, @y)
    end
  end

  def left
    turn(-90)
  end

  def right
    turn(90)
  end

  def report
    "X: #{x}, Y: #{y}, Face: #{facing}"
  end

  def valid_position?(x, y)
    (0..4).cover?(x) && (0..4).cover?(y)
  end

  def valid_direction?(facing)
    FS.include?(facing)
  end

  def turn(degrees)
    current_index = FS.index(facing)
    new_index = (current_index + degrees / 90) % 4
    @facing = FS[new_index]
  end
end

robot = Bot.new
robot.place(0, 0, 'NORTH')
# fill steps you want into a file
File.readlines("steps.txt").each do |n|
  sleep(0.5)
  n = n.strip
  robot.send(n) if %w(move right left).include?(n)
  puts "#{n} -> #{robot.report}"
end
