# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @report = reports(:report1)
  end

  test 'editable? should return true when the target user is the same as the report owner' do
    assert @report.editable?(@user)
  end

  test 'editable? should return false when the target user is different from the report owner' do
    assert_not @report.editable?(users(:two))
  end

  test 'created_on should return the date of the report creation' do
    assert_equal @report.created_at.to_date, @report.created_on
  end
end
