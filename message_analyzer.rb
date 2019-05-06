class MessageAnalyzer
  attr_reader :pattern

  def initialize(pattern)
    @pattern = pattern
  end

  def match?(text)
    @pattern === text
  end

  def get_keyword(text)
    keyword = @pattern.match(text).post_match
  end
end