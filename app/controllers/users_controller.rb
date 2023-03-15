# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show following followers]

  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show; end

  def following
    @title = 'Following'
    @users = @user.following.order(:id)
    render 'friendships'
  end

  def followers
    @title = 'Followers'
    @users = @user.followers.order(:id)
    render 'friendships'
  end

  private

  def set_user
    @user  = User.find(params[:id])
  end
end
