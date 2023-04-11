# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :set_user

  def create
    friendship = current_user.active_friendships.new(followed: @user)
    if friendship.save
      redirect_to @user, notice: t('.notice')
    else
      redirect_to @user, alert: t('.alert')
    end
  end

  def destroy
    friendship = current_user.active_friendships.find_by(followed: @user)
    if friendship&.destroy
      redirect_to @user, notice: t('.notice')
    else
      redirect_to @user, alert: t('.alert')
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
