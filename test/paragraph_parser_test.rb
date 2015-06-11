require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/paragraph_parser'

class ParagraphParserTest < Minitest::Test

  def test_if_it_exists
    assert ParagraphParser
  end

  def test_if_strong_emphasis_tags_replace_the_double_star_chars
    text = <<-EOS
'You just *have* to try the cheesecake,' he said. Ever since it appeared in
**Food & Wine** this place has been packed every night.
    EOS
    expected_text = <<-EOS
'You just *have* to try the cheesecake,' he said. Ever since it appeared in
<strong>Food & Wine</strong> this place has been packed every night.
    EOS

    paragraph = ParagraphParser.new(text)
    assert_equal expected_text, paragraph.strong
  end

  def test_if_italic_emphasis_tags_replace_the_star_char
    text = <<-EOS
'You just *have* to try the cheesecake,' he said. Ever since it appeared in
**Food & Wine** this place has been packed every night.
    EOS

    expected_text = <<-EOS
'You just <em>have</em> to try the cheesecake,' he said. Ever since it appeared in
<em></em>Food & Wine<em></em> this place has been packed every night.
    EOS

    paragraph = ParagraphParser.new(text)
    assert_equal expected_text, paragraph.emphasis
  end

  def test_if_line_breaks_are_added

    text = <<-EOS
'You just *have* to try the cheesecake,' he said. Ever since it appeared in
**Food & Wine** this place has been packed every night.
    EOS

    expected_text = <<-EOS

<p>
  'You just *have* to try the cheesecake,' he said. Ever since it appeared in<br>**Food & Wine** this place has been packed every night.<br>
</p>

    EOS
    paragraph = ParagraphParser.new(text)
    assert_equal expected_text, paragraph.wrap_in_p_tags!
  end

end
