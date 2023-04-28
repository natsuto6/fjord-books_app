# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test 'following? should return true if user is being followed' do
    user_to_follow = users(:two)
    @user.follow(user_to_follow)

    assert @user.following?(user_to_follow)
  end

  test 'following? should return false if user is not being followed' do
    user_not_to_follow = users(:three)

    assert_not @user.following?(user_not_to_follow)
  end

  test 'followed_by? should return true if user is being followed by another user' do
    user_follower = users(:two)
    user_follower.follow(@user)

    assert @user.followed_by?(user_follower)
  end

  test 'followed_by? should return false if user is not being followed by another user' do
    user_non_follower = users(:three)

    assert_not @user.followed_by?(user_non_follower)
  end

  test 'follow should create a relationship' do
    user_to_follow = users(:two)

    assert_difference '@user.active_relationships.count', 1 do
      @user.follow(user_to_follow)
    end
  end

  test 'unfollow should destroy a relationship' do
    user_to_unfollow = users(:two)
    @user.follow(user_to_unfollow)

    assert_difference '@user.active_relationships.count', -1 do
      @user.unfollow(user_to_unfollow)
    end
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
