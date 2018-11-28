require 'test_helper'

class JobTitleTest < ActiveSupport::TestCase
  def setup
    @job_title = create(:job_title)
  end

  test "should be valid the job_title instance" do
	assert @job_title.valid?
  end

  test "area_name should be present" do
	@job_title.name = ""
	assert_not @job_title.valid?
  end
end
