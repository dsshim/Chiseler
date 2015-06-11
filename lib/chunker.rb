class Chunker

  attr_reader :input

  def initialize(input)
    @input = input
  end

  def chunk
    @split_input = @input.split("\n\n")
    @split_input.delete("")
    @split_input
  end

end

