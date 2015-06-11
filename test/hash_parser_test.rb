require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require '../lib/hash_parser'

class HashParserTest < Minitest::Test

  def test_if_it_exists
    assert HashParser
  end

  def test_it_can_convert_text_input_into_an_array

    text = "## Chapter 1: The Beginning"
    expected_output = ["## Chapter 1: The Beginning"]
    hash = HashParser.new(text)

    assert_equal expected_output, hash.lines
  end

  def test_it_can_convert_hashes_to_html_tags

    text = "## Chapter 1: The Beginning"
    expected_output = "<h2>Chapter 1: The Beginning</h2>\n\n"
    hash = HashParser.new(text)
    hash.lines

    assert_equal expected_output, hash.convert_hashes
  end

end