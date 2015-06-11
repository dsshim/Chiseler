require "pry"
require "../lib/hash_parser"
require "../lib/list_parser"
require "../lib/paragraph_parser"
require "../lib/file_io"
require "../lib/chunker"
require "../lib/chunk_router"
require "../lib/link_parser"
require "../lib/image_parser"

class Chisel

  attr_reader :chunker, :identifier, :my_input, :my_output

  def initialize(chunker)
    @chunker = chunker
    @identifier = ChunkRouter.new
    @my_input = ARGV[0]
    @my_output = ARGV[1]
    @write = FileIO.new(@my_input, @my_output)
  end

  def parse
    @chunker.map do |text|
      type = identifier.identify(text)

      case type
        when :paragraph then
          ParagraphParser.parse(text) && @write.write_message(ParagraphParser.parse(text))
        when :header then
          HashParser.parse(text) && @write.write_message(HashParser.parse(text))
        when :list then
          ListParser.parse(text) && @write.write_message(ListParser.parse(text))
        when :links then
          LinkParser.parse(text) && @write.write_message(LinkParser.parse(text))
        when :images then
          ImageParser.parse(text) && @write.write_message(ImageParser.parse(text))
      end
    end.join
  end

end


my_input = ARGV[0]
my_output = ARGV[1]
read = FileIO.new(my_input, my_output)
text = read.read_message
read.write_message("")
read_output = File.open(my_output, "r")
read_input = File.open(my_input, "r")
chunker = Chunker.new(text).chunk
parser = Chisel.new(chunker)
parser.parse
read_input.rewind
read_output.rewind
puts "Converted #{my_input} (#{read_input.readlines.count.to_s} lines) to #{my_output} (#{read_output.readlines.count.to_s} lines)"


