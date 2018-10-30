require 'test_helper'

class CriteriaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @criterium = criteria(:one)
  end

  test "should get index" do
    get criteria_url
    assert_response :success
  end

  test "should get new" do
    get new_criterium_url
    assert_response :success
  end

  test "should create criterium" do
    assert_difference('Criterium.count') do
      post criteria_url, params: { criterium: { criteria_type: @criterium.criteria_type, degree_id: @criterium.degree_id, score: @criterium.score } }
    end

    assert_redirected_to criterium_url(Criterium.last)
  end

  test "should show criterium" do
    get criterium_url(@criterium)
    assert_response :success
  end

  test "should get edit" do
    get edit_criterium_url(@criterium)
    assert_response :success
  end

  test "should update criterium" do
    patch criterium_url(@criterium), params: { criterium: { criteria_type: @criterium.criteria_type, degree_id: @criterium.degree_id, score: @criterium.score } }
    assert_redirected_to criterium_url(@criterium)
  end

  test "should destroy criterium" do
    assert_difference('Criterium.count', -1) do
      delete criterium_url(@criterium)
    end

    assert_redirected_to criteria_url
  end
end