require 'message_analyzer'

class MessageAnalyzerTest < Test::Unit::TestCase
  def setup
    pattern = /^ご飯[[:space:]|\s]*/
    @target = MessageAnalyzer.new(pattern)
  end

  def test_match
    text = 'ご飯'
    expected = true
    actual = @target.match? text
    assert_equal(expected, actual)
  end

  def test_discord
    text = 'abcご飯def'
    expected = false
    actual = @target.match? text
    assert_equal(expected, actual)
  end

  def test_get_keyword_empty
    text = 'ご飯'
    expected = ''
    actual = @target.get_keyword text
    assert_equal(expected, actual)
  end

  def test_get_a_keyword
    text = 'ご飯　銀座　寿司'
    expected = '銀座　寿司'
    actual = @target.get_keyword text
    assert_equal(expected, actual)
  end

end
