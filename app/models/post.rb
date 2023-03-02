class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :long_title, ->{where "(length(title) > 15)"}
end
