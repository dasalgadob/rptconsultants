require 'test_helper'

class BusinessUnitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @business_unit = business_units(:one)
  end

  test "should get index" do
    get business_units_url
    assert_response :success
  end

  test "should get new" do
    get new_business_unit_url
    assert_response :success
  end

  test "should create business_unit" do
    assert_difference('BusinessUnit.count') do
      post business_units_url, params: { business_unit: { company_id: @business_unit.company_id, name: @business_unit.name } }
    end

    assert_redirected_to business_unit_url(BusinessUnit.last)
  end

  test "should show business_unit" do
    get business_unit_url(@business_unit)
    assert_response :success
  end

  test "should get edit" do
    get edit_business_unit_url(@business_unit)
    assert_response :success
  end

  test "should update business_unit" do
    patch business_unit_url(@business_unit), params: { business_unit: { company_id: @business_unit.company_id, name: @business_unit.name } }
    assert_redirected_to business_unit_url(@business_unit)
  end

  test "should destroy business_unit" do
    assert_difference('BusinessUnit.count', -1) do
      delete business_unit_url(@business_unit)
    end

    assert_redirected_to business_units_url
  end
end
