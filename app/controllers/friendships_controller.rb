# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :other_user

  def create
    current_user.active_friendships.create!(followed: @other_user)
    redirect_to @other_user
  end

  def destroy
    current_user.active_friendships.find(params[:id]).destroy
    redirect_to @other_user
  end

  private

  def other_user
    @other_user = User.find(params[:user_id])
  end
end
