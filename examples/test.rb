require 'techplater'

parser = Techplater::Parser.new(File.read('/tmp/sample'))
parser.parse!

puts parser.template
puts parser.chunks