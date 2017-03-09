require 'test_helper'

class TalenttoolsApiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TalenttoolsApi::VERSION
  end

  def test_project_creation
    response = TalenttoolsApi::Project.create(name: "Skippad Leaders 02/17", tool: "custom_style_view", language: "en", deadline: 4.months.from_now.strftime("%Y-%m-%d"), company_name: "Skippad Leaders Co.")
    @project = response[:data]

    refute_nil @project
    refute_nil @project[:id]
    assert_equal response[:success], 1
    assert_nil response[:error]
  end

  def test_project_report_types
    @project = TalenttoolsApi::Project.get_report_types(690)
    #puts @project.to_params 
    #puts @project[:data][:report_types]
    refute_nil @project[:data][:report_types]
    assert_equal @project[:success], 1
    assert_nil @project[:error]
  end

  def test_project_creation_with_errors
    @project = TalenttoolsApi::Project.create(name: "", tool: "", language: "en", deadline: 4.months.from_now.strftime("%Y-%m-%d"), company_name: "Skippad Leaders Co.")

    refute_nil @project[:error], "Errors should not be nil!"
    assert_equal @project[:error], "Invalid tool", "Error should be: Invalid tool"
    assert_nil @project[:data][:id], "Expected project_id to be empty"
    assert_equal @project[:success], 0 #not successful
  end

  def test_project_update
    @project = TalenttoolsApi::Project.update(679, {name: "Skippad Leaders 02/17 - 2", tool: "custom_style_view", language: "en", deadline: 2.months.from_now.strftime("%Y-%m-%d"), company_name: "Skippad Leaders Co."})
    puts @project.to_params 
    refute_nil @project
    refute_nil @project[:data][:id]
    assert_equal @project[:data][:id], 679
    assert_equal @project[:success], 1
    assert_nil @project[:error]
  end

  def test_project_update_wrong_parameters
    @project = TalenttoolsApi::Project.update(679, {name: "Skippad Leaders 02/17 - 2", tool: "custom_style_view", language: "en-gb", deadline: 2.months.from_now.strftime("%Y-%m-%d"), company_name: "Skippad Leaders Co."})
    #puts @project.to_params
    #puts @project[:success]
    #puts @project[:error].nil?
    #puts @project.error.to_s
    
    refute_nil @project[:error], "Errors should not be nil!"
    assert_equal @project[:error], "The language is not available for this tool", "Error should be: Invalid tool"
    assert_equal @project[:success], 0 #not successful
  end


  def test_participant_creation
    @participant = TalenttoolsApi::Participant.create(679, {first_name: "Donna", last_name: "Dixon", email: "tgriffin@wordware.net"})

    assert_nil @participant[:error], "Errors should not be nil!"
    refute_nil @participant[:data][:participant_id], "Expected a participant_id"
    assert_equal @participant[:success], 1 #successful
  end

  def test_participant_update
    @participant = TalenttoolsApi::Participant.update(679, 974, {first_name: "Donna", last_name: "Dixon", email: "dgriffen@wordware.net"})

    assert_nil @participant[:error], "Errors should not be nil!"
    refute_nil @participant[:data][:participant_id], "Expected a participant_id"
    assert_equal @participant[:data][:participant_id], 974
    assert_equal @participant[:success], 1 #successful
  end

  def test_participant_assessment_url
    @participant = TalenttoolsApi::Participant.get_assessment_link(679, 974)

    assert_nil @participant[:error], "Errors should not be nil!"
    refute_nil @participant[:data][:url], "URL is expected"
    assert_equal @participant[:success], 1 #successful
  end

  def test_participant_assessment_status
    @participant = TalenttoolsApi::Participant.get_assessment_status(679, 974)
    #puts @participant.to_params

    assert_nil @participant[:error], "Errors should not be nil!"
    refute_nil @participant[:data][:completed], "Completed status is expected"
    assert_equal @participant[:success], 1 #successful
  end

  def test_participant_report_url
    @participant = TalenttoolsApi::Participant.get_assessment_link(679, 974)

    refute_nil @participant[:error], "Errors should not be nil!"
    assert_nil @participant[:data][:url], "URL is expected"
    assert_equal @participant[:success], 0 #successful
  end

  def test_participant_report_url_without_params
    @participant = TalenttoolsApi::Participant.get_report_link(679, 974, {type: 8})

    refute_nil @participant[:error], "Errors should not be nil!"
    assert_nil @participant[:data][:url], "URL is expected"
    assert_equal @participant[:success], 1 #successful
  end

  def test_participant_creation_no_project
    @participant = TalenttoolsApi::Participant.create(1, {first_name: "Donna", last_name: "Dixon", email: "tgriffin@wordware.net"})

    refute_nil @participant[:error], "Errors should not be nil!"
    assert_nil @participant[:data][:participant_id], "Expected a participant_id"
    assert_equal @participant[:error], "Project not found", "Error should be: project not found"
    assert_equal @participant[:success], 0 #not successful
  end

  def test_participant_creation_with_errors
    @participant = TalenttoolsApi::Participant.create(679, {first_name: "Donna", last_name: "Dixon", email: ""})

    refute_nil @participant[:error], "Errors should not be nil!"
    assert_nil @participant[:data][:participant_id], "Expected a participant_id"
    assert_equal @participant[:success], 0 #not successful
  end
end
