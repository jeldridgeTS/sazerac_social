class AddThumbImageToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :thumb_image, :text
  end
end
