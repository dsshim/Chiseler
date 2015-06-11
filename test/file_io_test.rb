require "../lib/file_io"
require 'minitest/autorun'
require 'minitest/pride'

class FileIOTest < Minitest::Test

  def test_if_it_exists
    assert FileIO
  end

  def test_if_it_reads_file
    file = FileIO.new
    assert true, file
  end

  def test_if_it_writes_file
    file = FileIO.new
    text = ""
    assert Fixnum, file.write_message(text)
  end

end
