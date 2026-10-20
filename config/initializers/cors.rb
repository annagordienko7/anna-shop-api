Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Здесь мы указываем адрес, на котором обычно запускается React
    origins "http://localhost:3000"

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ["Authorization"] # Это нужно, чтобы React видел JWT-токен при логине
  end
end
