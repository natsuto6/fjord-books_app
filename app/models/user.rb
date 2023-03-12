# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :active_friendships, class_name: 'Friendship',
                                foreign_key: 'follower_id',
                                dependent: :destroy,
                                inverse_of: :follower
  has_many :passive_friendships, class_name: 'Friendship',
                                 foreign_key: 'followed_id',
                                 dependent: :destroy,
                                 inverse_of: :followed
end
