class ChunkRouter

  def identify(input)
    if input[0].to_i>0
      @first_char = input[0]
    end
    if input.include?("http:") || input.include?("www")
      :links
    elsif input.start_with?("1. ") || input.start_with?("*") #("#{@first_char}")
      :list
    elsif input.include?("#")
      :header
    else
      :paragraph
    end
  end

end

