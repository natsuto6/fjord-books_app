# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @john = users(:john)
    @john_report = reports(:john_report)
  end

  test 'editable? returns true if the target user is the owner of the report' do
    assert @john_report.editable?(@john)
    assert_not @john_report.editable?(users(:mike))
  end

  test 'created_on should return the date of the report creation' do
    assert_equal Time.current.to_date, @john_report.created_on
  end
end
