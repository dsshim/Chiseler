class HashParser

  def initialize(text)
    @hash_txt = text
  end

  def self.parse(text)
    new(text).parse
  end

  def parse
    lines
    convert_hashes
  end

  def lines
    @lines = @hash_txt.split("\n")
  end

  def convert_hashes
    @lines.map do |line|
      if line.include?("#") == true
        hashes = line.count("#")
        line.delete!("#").strip!
        line.prepend("<h#{hashes}>")<<"</h#{hashes}>\n\n"
      end
    end.join
  end

end

