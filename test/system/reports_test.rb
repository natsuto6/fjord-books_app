# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:john_report)

    visit root_url
    fill_in 'Eメール', with: 'john@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報'
  end

  test 'creating a Report' do
    visit reports_url
    click_on '新規作成'

    fill_in 'タイトル', with: '本日の日報'
    fill_in '内容', with: 'Railsでテストを書く'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '本日の日報'
    assert_text 'Railsでテストを書く'
  end

  test 'updating a Report' do
    visit reports_url
    click_link '詳細', match: :first

    assert_text "John's Report"
    assert_text "This is John's report"

    click_on '編集', match: :prefer_exact
    fill_in 'タイトル', with: 'ジョンのレポート'
    fill_in '内容', with: 'これはジョンのレポートです'

    click_on '更新する'
    assert_text '日報が更新されました。'
    assert_text 'ジョンのレポート'
    assert_text 'これはジョンのレポートです'
  end

  test 'destroying a Report' do
    visit reports_url

    assert_text "John's Report"

    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '日報が削除されました。'
    assert_no_text "John's Report"
  end
end
