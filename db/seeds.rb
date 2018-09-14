10.times do |article|
  Article.create!(
    title: "Article number #{article}",
    body: "Big ole body article number: #{article}. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    thumb_image: "https://via.placeholder.com/350x150"
  )
end

puts '10 articles created'

Article.all.each do |article|
  random_number = rand 10
  if random_number > 0
    random_number.times do
      article.comments.create!(body: "I really dig article #{article.id}")
    end
  end
end

puts 'Comments created!'
