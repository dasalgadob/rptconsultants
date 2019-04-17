require 'test_helper'

class HistoricsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @historic = historics(:one)
  end

  test "should get index" do
    get historics_url
    assert_response :success
  end

  test "should get new" do
    get new_historic_url
    assert_response :success
  end

  test "should create historic" do
    assert_difference('Historic.count') do
      post historics_url, params: { historic: { new_fields: @historic.new_fields, previous_fields: @historic.previous_fields, type: @historic.type, user_id: @historic.user_id, valuation_id: @historic.valuation_id } }
    end

    assert_redirected_to historic_url(Historic.last)
  end

  test "should show historic" do
    get historic_url(@historic)
    assert_response :success
  end

  test "should get edit" do
    get edit_historic_url(@historic)
    assert_response :success
  end

  test "should update historic" do
    patch historic_url(@historic), params: { historic: { new_fields: @historic.new_fields, previous_fields: @historic.previous_fields, type: @historic.type, user_id: @historic.user_id, valuation_id: @historic.valuation_id } }
    assert_redirected_to historic_url(@historic)
  end

  test "should destroy historic" do
    assert_difference('Historic.count', -1) do
      delete historic_url(@historic)
    end

    assert_redirected_to historics_url
  end
end
