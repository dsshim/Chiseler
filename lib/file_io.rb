class FileIO

  attr_accessor :input, :output

  def initialize(input="my_input.markdown", output="my_output.html")
    @input = input
    @output = output
  end

  def write_message(input)
    message = File.open(@output, "a")
    message.write(input)
    message.close
  end

  def read_message
    read =File.open(@input, "r")
    read.read
  end

  def read_html_message
    read = File.open(@output, "r")
    read.read
  end

end


