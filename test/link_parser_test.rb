require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require '../lib/link_parser'

class LinkParserTest < Minitest::Test

  def test_if_it_exists
    assert LinkParser
  end

  def test_if_links_are_parsed_with_html_tags_within_text
    text = <<-EOS
'You just *have* to try the *cheesecake,' **he said**.  Ever since* it appeared in
**Food & Wine** this place has been packed every night.  dumy dkeh skeh skehskdjdi
**dlksjdf**. asdkjfasldk.  *laksjdflksdjfm*, *laksjd*.
alskdjf. [This link](http://example.net/) **laksjdfalskdf**.
*lksjdf*.
    EOS

    expected_text = <<-EOS

<p>
  'You just <em>have</em> to try the <em>cheesecake,' <strong>he said</strong>.  Ever since</em> it appeared in<br><strong>Food & Wine</strong> this place has been packed every night.  dumy dkeh skeh skehskdjdi<br><strong>dlksjdf</strong>. asdkjfasldk.  <em>laksjdflksdjfm</em>, <em>laksjd</em>.<br>alskdjf. <a href='http://example.net/'>This link</a> <strong>laksjdfalskdf</strong>.<br><em>lksjdf</em>.<br>
</p>

    EOS

    link = LinkParser.new(text)
    assert_equal expected_text, link.link
  end

  def test_links_are_parsed_with_html_tags_without_extra_text
    text = <<-EOS
[This link](http://example.net/)
    EOS

    expected_text = <<-EOS

<p>
  <a href='http://example.net/'>This link</a><br>
</p>

    EOS
    link = LinkParser.new(text)
    assert_equal expected_text, link.link
  end

  def test_links_are_parsed_with_html_tags_within_a_header
    text = <<-EOS
## Chapter 1: The [This link](http://example.net/) Beginning
    EOS

    expected_text = <<-EOS
<h2>Chapter 1: The <a href='http://example.net/'>This link</a> Beginning</h2>

    EOS
    link = LinkParser.new(text)
    assert_equal expected_text, link.link
  end

  def test_if_links_are_parsed_with_html_tags_within_a_list
    text = <<-EOS
* Sushi
* Barbeque [This link](http://example.net/)
* Mexican
    EOS

    expected_text = <<-EOS
<ul>
  <li>Sushi</li>
  <li>Barbeque <a href='http://example.net/'>This link</a></li>
  <li>Mexican</li>
</ul>

    EOS
    link = LinkParser.new(text)
    assert_equal expected_text, link.link
  end

end
