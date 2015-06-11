require "pry"
class ListParser

  attr_accessor :text, :format_text, :f_list, :list, :first_char

  def initialize(text)
    @text = text
    @f_list = ""
  end

  def self.parse(text)
    new(text).parse
  end

  def parse
    paragraph
    apply_tags
  end

  def paragraph
    para_text = @text.split("\n")
    para_text.map do |word|
      list = word[2..-1]
      @first_char = word[0]
      format_list = list.prepend("  <li>")<<("</li>\n")
      @f_list<<format_list
    end
    @f_list
  end

  def apply_tags
    if @first_char.to_i > 0
      @f_list.prepend("<ol>\n")<<"</ol>\n\n"

    elsif @f_list.empty?
    else
      @f_list.prepend("<ul>\n")<<"</ul>\n\n"
    end
  end

end

