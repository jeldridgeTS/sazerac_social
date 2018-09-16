class AddMainImageToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :main_image, :text
  end
end
