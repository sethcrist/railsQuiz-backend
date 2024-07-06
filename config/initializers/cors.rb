Rails.application.config.middle.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001'
    resources '*',
              headers: ["Authorization"],
              expose: ["Authorization"],
              methods: [:get, :post, :put, :patch, :delete, :options, :head],
              max_age: 600
  end
end