require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require '../lib/list_parser'


class ListParserTest < Minitest::Test

  def test_if_it_exist
    assert ListParser
  end

  def test_if_list_elements_are_tagged_with_li_tags
    text = <<-EOS
1. Horror
2. Mystery
3. Documentary
    EOS

    expected_text = <<-EOS
  <li> Horror</li>
  <li> Mystery</li>
  <li> Documentary</li>
    EOS

    list = ListParser.new(text)
    #list.format
    #list.paragraph

    assert_equal expected_text, list.paragraph

  end

  def test_if_list_output_contains_ordered_tags
    text = <<-EOS
1. Horror
2. Mystery
3. Documentary
    EOS

    expected_text = <<-EOS
<ol>
  <li> Horror</li>
  <li> Mystery</li>
  <li> Documentary</li>
</ol>

    EOS
    assert_equal expected_text, ListParser.parse(text)
  end

  def test_if_list_output_contains_unordered_tags
    text = <<-EOS
* Action
* Thriller
* Horror
    EOS

    expected_text = <<-EOS
<ul>
  <li>Action</li>
  <li>Thriller</li>
  <li>Horror</li>
</ul>

    EOS
    assert_equal expected_text, ListParser.parse(text)
  end

end
