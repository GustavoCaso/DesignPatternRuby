require_relative './encrypter'

class StringIOAdapter
  def initialize(string)
    @string = string
    @position = 0
  end

  def eof_condition?
    @position >= @string.length
  end

  def getc
    raise EOFError  if eof_condition?
    ch = @string[@position]
    @position += 1
    return ch
  end

  def eof?
    eof_condition?
  end
end


encrypter = Encrypter.new('XYZZY')
reader= StringIOAdapter.new('We attack at dawn')
writer=File.open('out.txt', 'wd')
encrypter.encrypt(reader, writer)
