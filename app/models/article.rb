class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  enum status: { draft: 0, published: 1 }

  has_many :comments, dependent: :destroy
  validates_presence_of :title, :body, :thumb_image, :main_image
end
