json.extract! article, :id, :title, :body, :thumb_image, :main_image, :all_tags, :main_image_title, :main_image_alt_text, :created_at, :updated_at
json.url article_show_path(article, format: :json)
