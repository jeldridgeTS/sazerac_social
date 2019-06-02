Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins 'localhost:4200'
    origins 'http://localhost:3000', 'https://sazerac-social.herokuapp.com'
    resource '/api/v1/*',
      headers: :any,
      credentials: true,
      methods: %i(get post put patch delete options head)
  end
end
