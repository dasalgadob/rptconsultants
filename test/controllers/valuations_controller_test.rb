require 'test_helper'

class ValuationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @valuation = valuations(:one)
  end

  test "should get index" do
    get valuations_url
    assert_response :success
  end

  test "should get new" do
    get new_valuation_url
    assert_response :success
  end

  test "should create valuation" do
    assert_difference('Valuation.count') do
      post valuations_url, params: { valuation: { area_impact_id: @valuation.area_impact_id, definition_supervision_id: @valuation.definition_supervision_id, degree_id: @valuation.degree_id, influence_id: @valuation.influence_id, job_title_id: @valuation.job_title_id, knowledge_id: @valuation.knowledge_id, position_type_id: @valuation.position_type_id, risk_decision_id: @valuation.risk_decision_id, score: @valuation.score, skill_id: @valuation.skill_id, sustainability_id: @valuation.sustainability_id } }
    end

    assert_redirected_to valuation_url(Valuation.last)
  end

  test "should show valuation" do
    get valuation_url(@valuation)
    assert_response :success
  end

  test "should get edit" do
    get edit_valuation_url(@valuation)
    assert_response :success
  end

  test "should update valuation" do
    patch valuation_url(@valuation), params: { valuation: { area_impact_id: @valuation.area_impact_id, definition_supervision_id: @valuation.definition_supervision_id, degree_id: @valuation.degree_id, influence_id: @valuation.influence_id, job_title_id: @valuation.job_title_id, knowledge_id: @valuation.knowledge_id, position_type_id: @valuation.position_type_id, risk_decision_id: @valuation.risk_decision_id, score: @valuation.score, skill_id: @valuation.skill_id, sustainability_id: @valuation.sustainability_id } }
    assert_redirected_to valuation_url(@valuation)
  end

  test "should destroy valuation" do
    assert_difference('Valuation.count', -1) do
      delete valuation_url(@valuation)
    end

    assert_redirected_to valuations_url
  end
end
