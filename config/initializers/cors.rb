Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins 'localhost:4200'
    origins '*'
    resource '*',
      headers: :any,
      expose: ["Authorization"],
      methods: %i(get post put patch delete options head)
  end
end
