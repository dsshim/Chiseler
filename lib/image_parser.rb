class ImageParser

  def initialize(text)
    @text = text
  end

  def self.parse(text)
    new(text).parse
  end

  def parse
    image
  end

  def image
    if @text.nil?
    else
      open_bracket = @text.index("[")
      closed_bracket = @text.index("]")
      link_name = @text[open_bracket+1...closed_bracket]

      open_paren = @text.index("(")
      closed_paren = @text.index(")")
      link_text = @text[open_paren+1...closed_paren]

      image = "[id]: '#{link_text}'"
      delete_link_text = @text.split(")").collect { |char| char.split("(")[0] }.join.split("]").collect { |char_brack| char_brack.split("[")[0] }.join

      para_text_link = delete_link_text.insert(open_bracket, image)
      ParagraphParser.parse(para_text_link.sub("!", "").sub("'", ""))
    end
  end

end

