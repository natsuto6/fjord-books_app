# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:john)
  end

  test 'following? should return true if user is being followed' do
    user_to_follow = users(:mike)
    @user.follow(user_to_follow)

    assert @user.following?(user_to_follow)
  end

  test 'following? should return false if user is not being followed' do
    user_not_to_follow = users(:alice)

    assert_not @user.following?(user_not_to_follow)
  end

  test 'followed_by? should return true if user is being followed by another user' do
    user_follower = users(:mike)
    user_follower.follow(@user)

    assert @user.followed_by?(user_follower)
  end

  test 'followed_by? should return false if user is not being followed by another user' do
    user_non_follower = users(:alice)

    assert_not @user.followed_by?(user_non_follower)
  end

  test 'unfollow should destroy a relationship' do
    user_to_unfollow = users(:mike)
    @user.follow(user_to_unfollow)
    assert @user.following?(user_to_unfollow)

    @user.unfollow(user_to_unfollow)
    assert_not @user.following?(user_to_unfollow)
  end

  test 'name_or_email should return name if present' do
    @user.name = 'John'
    @user.email = 'john@example.com'

    assert_equal 'John', @user.name_or_email
  end

  test 'name_or_email should return email if name is not present' do
    @user.name = nil
    @user.email = 'john@example.com'

    assert_equal 'john@example.com', @user.name_or_email
  end
end
