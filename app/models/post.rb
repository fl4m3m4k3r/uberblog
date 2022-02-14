class Post < ApplicationRecord
  belongs_to  :user

  has_many    :comments,  dependent: :destroy
  has_many    :likes,     dependent: :destroy

  scope :ordered, -> { includes(:user, :likes, :comments).order("created_at DESC") }
end
