class AddColumnsToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :main_image_title, :string
    add_column :articles, :main_image_alt_text, :string
  end
end
