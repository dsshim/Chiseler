require "../lib/paragraph_parser"
require "../lib/hash_parser"
require "../lib/list_parser"

class LinkParser

  def self.parse(text)
    new(text).parse
  end

  def initialize(text)
    @text = text
  end

  def parse
    link
  end

  def link
    if @text.nil?
    elsif @text.start_with?("*") || @text.start_with?("1")
      ListParser.parse(delete_text)

    elsif @text.include?("#")
      HashParser.parse(delete_text)
    else
      ParagraphParser.parse(delete_text)
    end
  end

  def delete_text
    delete_link_text = reinsert_link
    para_text_link = delete_link_text.insert(get_bracket_index, get_link)
  end

  def reinsert_link
    @text.split(")").collect { |char| char.split("(")[0] }.join.split("]").collect { |char_brack| char_brack.split("[")[0] }.join
  end

  def get_link
    "<a href='#{get_link_text}'>#{get_link_name}</a>"
  end


  def get_bracket_index
    @text.index("[")
  end

  def get_link_text
    @text[@text.index("(")+1...@text.index(")")]
  end

  def get_link_name
    @text[@text.index("[")+1...@text.index("]")]
  end

end

