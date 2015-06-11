class ParagraphParser

  def self.parse(text)
    new(text).parse
  end

  def initialize(text)
    @text = text
  end

  def parse
    strong
    emphasis
    wrap_in_p_tags!
  end

  def strong
    char_counts = @text.count("**")/2
    until char_counts == 0
      @text.sub!("**", "<strong>")
      @text.sub!("**", "</strong>")
      char_counts -= 1
    end
    @text
  end

  def emphasis
    char_counts = @text.count("*")/2
    until char_counts == 0
      @text.sub!("*", "<em>")
      @text.sub!("*", "</em>")
      char_counts -= 1
    end
    @text
  end

  def wrap_in_p_tags!
    @text.gsub!("\n", "<br>")
    "\n<p>\n" + "  #{@text}" +"\n</p>\n\n"
  end

end


