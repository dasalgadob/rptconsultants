require 'test_helper'

class CriteriaTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @criteria_type = criteria_types(:one)
  end

  test "should get index" do
    get criteria_types_url
    assert_response :success
  end

  test "should get new" do
    get new_criteria_type_url
    assert_response :success
  end

  test "should create criteria_type" do
    assert_difference('CriteriaType.count') do
      post criteria_types_url, params: { criteria_type: { name: @criteria_type.name } }
    end

    assert_redirected_to criteria_type_url(CriteriaType.last)
  end

  test "should show criteria_type" do
    get criteria_type_url(@criteria_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_criteria_type_url(@criteria_type)
    assert_response :success
  end

  test "should update criteria_type" do
    patch criteria_type_url(@criteria_type), params: { criteria_type: { name: @criteria_type.name } }
    assert_redirected_to criteria_type_url(@criteria_type)
  end

  test "should destroy criteria_type" do
    assert_difference('CriteriaType.count', -1) do
      delete criteria_type_url(@criteria_type)
    end

    assert_redirected_to criteria_types_url
  end
end
