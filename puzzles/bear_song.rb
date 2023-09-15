def recite(bottles_count,verse)

  output = ""
  while(bottles_count > 0) do

    if bottles_count == 2
      str = "2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n"
    elsif bottles_count == 1
       str = "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"
    elsif bottles_count == 0
       str = "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
    else
       str = "#{bottles_count} bottles of beer on the wall, #{bottles_count} bottles of beer.\nTake one down and pass it around, #{bottles_count - 1} bottles of beer on the wall.\n"
    end
    output = output + str
    bottles_count = bottles_count - 1

  end
  output.split("\n").take(verse)
end


puts recite(99,2)