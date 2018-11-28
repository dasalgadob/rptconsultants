require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

  def setup
	@company = create(:company)
  end

  test "should be valid the company instance" do
	assert @company.valid?
  end

  test "area_name should be present" do
	@company.name = ""
	assert_not @company.valid?
  end
end
