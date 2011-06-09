require 'rubygems'
require 'bitmap'

unless ARGV.size == 2
  puts "USAGE: ruby main.rb <image_file> <text_file>"
  exit
end

# Read image name
input_image, input_string = ARGV

# Read input bitmap
print "Reading bitmap..."
bmp = Bitmap.read(File.read("#{input_image}"))
puts 'done'

# Convert string to bit array
input = IO.read(input_string)
input_bits = Array.new
input.bytes.each do |byte|
  7.downto(0){|i| input_bits << byte[i] }
end

print "Input bits: "
puts input_bits.join

# Insert string bits into the bitmap image
print 'Crypting text...'
bmp.pixels.each_with_index do |pixel, i|
  bit = input_bits.size < i ? 0 : input_bits[i].to_i
  pixel.assign( bit == 0 ? (pixel & 254) : (pixel | 1) )
end
puts 'done'

# Save output bitmap
print 'Saving output...'
File.open('output.bmp', 'wb'){|f| bmp.write(f) }
puts 'done'