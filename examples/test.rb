require 'techplater'
require 'pp'

parser = Techplater::Parser.new(File.read('/tmp/sample'))
parser.parse!

puts 'Handlebar template: '
puts
puts parser.template
puts
puts 'Chunks: '
puts
pp parser.chunks