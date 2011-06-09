require 'bindata'

class Bitmap < BinData::Record
  endian :little

  string :magick, :read_length => 2
  uint32 :filesize
  uint16 :creator1
  uint16 :creator2
  uint32 :bmp_offset
  string :read_length => :ommit_until_pixel_array
  array :pixels, :read_until => :eof, :type => :bit8
  
  def ommit_until_pixel_array
    bmp_offset - 14
  end
end