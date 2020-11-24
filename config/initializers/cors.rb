Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
<<<<<<< HEAD
    origins 'http://localhost:3000', 'https://sazerac-social.herokuapp.com', 'http://sazerac-social.herokuapp.com'
||||||| merged common ancestors
    origins 'http://localhost:3000', 'https://sazerac-social.herokuapp.com'
=======
    origins 'http://localhost:3001', 'https://sazerac-social.herokuapp.com'
>>>>>>> main
    resource '*',
      headers: :any,
      credentials: true,
      methods: %i(get post put patch delete options head)
  end
end
