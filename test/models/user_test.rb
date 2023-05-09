# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @john = users(:john)
    @mike = users(:mike)
    @alice = users(:alice)
  end

  test 'following? should return true if user is being followed' do
    @john.follow(@mike)
    assert @john.following?(@mike)
  end

  test 'following? should return false if user is not being followed' do
    assert_not @john.following?(@alice)
  end

  test 'followed_by? should return true if user is being followed by another user' do
    @mike.follow(@john)
    assert @john.followed_by?(@mike)
  end

  test 'followed_by? should return false if user is not being followed by another user' do
    assert_not @john.followed_by?(@alice)
  end

  test 'unfollow should destroy a relationship' do
    @john.follow(@mike)
    assert @john.following?(@mike)

    @john.unfollow(@mike)
    assert_not @john.following?(@mike)
  end

  test 'name_or_email should return name if present' do
    @john.name = 'John'
    @john.email = 'john@example.com'

    assert_equal 'John', @john.name_or_email
  end

  test 'name_or_email should return email if name is not present' do
    @john.name = nil
    @john.email = 'john@example.com'

    assert_equal 'john@example.com', @john.name_or_email
  end
end
