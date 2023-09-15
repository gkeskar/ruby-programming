string = "The quick 12 brown foxes the jumped over the 10 lazy dogs"

p string =~ /quick/

p string =~ /z/ ? "valid" : "Invalid"
p string =~ /Z/i ? "valid" : "Invalid"

p string.to_enum(:scan, /\d+/).map { Regexp.last_match}
