class ToSum

  # each_with_object.with_index
  # def self.indices(integers, target)
  #   integers.each_with_object({}).with_index do | (number, result), index|
  #     number2 = target - number
  #     return [result[number2], index] if result[number2]
  #     result[number] = index
  #   end
  # end

  # my solution
  def self.indices(integers, target)
    integers.combination(2).filter{ |tuple| tuple[0] + tuple[1] == target }.flatten.map{ |number| integers.index(number) }.first(2)
  end

  if $PROGRAM_NAME == __FILE__
    # puts indices([2,4,5,8,11], 10)
    puts indices([12,14,5,8,6,11], 20)
  end

end
