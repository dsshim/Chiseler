require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require '../lib/chunker'


class ChunkerTest < Minitest::Test

  def test_if_chunker_class_exists
    assert Chunker
  end

  def test_if_it_separates_text_into_an_array_by_double_line_breaks
    text = <<-EOS
# My Life in Desserts

## Chapter 1: The Beginning

My favorite movies are:

1. Horror
2. Mystery
3. Documentary
    EOS

    expected_text = ["# My Life in Desserts", "## Chapter 1: The Beginning", "My favorite movies are:", "1. Horror\n2. Mystery\n3. Documentary\n"]
    chunk = Chunker.new(text)
    assert_equal expected_text, chunk.chunk
  end

end
