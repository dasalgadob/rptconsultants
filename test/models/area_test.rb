require 'test_helper'

class AreaTest < ActiveSupport::TestCase

  def setup
	@area = create(:area)
  end

  test "should be valid the area instance" do
	assert @area.valid?
  end

  test "name should be present" do
	@area.name = ""
	assert_not @area.valid?
  end
end
