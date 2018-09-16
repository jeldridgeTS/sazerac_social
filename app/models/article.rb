class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  enum status: { draft: 0, published: 1 }

  has_many :comments, dependent: :destroy
end
