require_relative 'spec_helper.rb'
require_relative '../lib/codez.rb'

class TestSmoke < Minitest::Test
  def test_add_two
    assert_equal(5, add_two(2))
  end
end

