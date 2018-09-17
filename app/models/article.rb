class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  enum status: { draft: 0, published: 1 }

  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings

  validates_presence_of :title, :body, :thumb_image, :main_image

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).articles
  end
end
