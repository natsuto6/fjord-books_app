# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:report1)

    visit root_url
    fill_in 'Eメール', with: 'one@example.com'
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
    click_on '編集', match: :prefer_exact

    fill_in 'タイトル', with: @report.title
    fill_in '内容', with: @report.content
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text @report.title
    assert_text @report.content
  end

  test 'destroying a Report' do
    visit reports_url

    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '日報が削除されました。'
    assert_no_text @report.title
  end
end
