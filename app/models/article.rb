class Article < ApplicationRecord
  include Placeholder
  extend FriendlyId

  friendly_id :title, use: :slugged

  enum status: { draft: 0, published: 1 }

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_one_attached :jumbotron_image
  has_many_attached :images

  validates_presence_of :title, :body, :thumb_image, :main_image, :main_image_title, :main_image_alt_text

  scope :published, ->() { where(status: "published") }

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  # ======================= #
  #         QUERIES         #
  # ======================= #

  def self.tagged_with(name)
    Tag.find_by_name!(name).articles
  end

  after_initialize :set_defaults

  def set_defaults
    self.thumb_image ||= Placeholder.image_generator(width: 350, height: 150)
    self.main_image  ||= Placeholder.image_generator(width: 1200, height: 300)
  end
end
