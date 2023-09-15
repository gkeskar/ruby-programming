def convert_temp (temp, input_scale: , output_scale: "Celsius")
  return temp if input_scale == "celsius" &&  output_scale == "Celsius"
  return temp if input_scale == "fahrenheit" &&  output_scale == "fahrenheit"
  return temp if input_scale == "kelvin" &&  output_scale == "kelvin"

  if input_scale == "fahrenheit" &&  output_scale == "Celsius"
    fah_to_cel(temp)
  elsif input_scale == "celsius" &&  output_scale == "fahrenheit"
    cel_to_fah(temp)
  elsif input_scale == "celsius" &&  output_scale == "kelvin"
    puts "came hre"
    cel_to_kel(temp)
  elsif input_scale == "kelvin" &&  output_scale == "Celsius"
    kel_to_cel(temp)
  elsif input_scale == "fahrenheit" &&  output_scale == "kelvin"
    cel_to_kel(fah_to_cel(temp))
  elsif input_scale == "kelvin" &&  output_scale == "fahrenheit"
    cel_to_fah(kel_to_cel(temp))
  end
end

def cel_to_fah(temp)
  temp * 1.8  + 32
end

def fah_to_cel(temp)
  (temp - 32) / 1.8
end

def kel_to_cel(temp)
  temp - 273.15
end

def cel_to_kel(temp)
  temp + 273.15
end

puts convert_temp(0, input_scale: 'celsius', output_scale: 'kelvin')
puts convert_temp(0, input_scale: 'celsius', output_scale: 'fahrenheit')