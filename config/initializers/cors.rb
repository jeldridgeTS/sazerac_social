Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001', 'https://sazerac-social.herokuapp.com'
    resource '*',
      headers: :any,
      credentials: true,
      methods: %i(get post put patch delete options head)
  end
end
