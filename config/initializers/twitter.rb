Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "jcEARkI2G775y8qyVUiJaA", ENV["CONSUMER_SECRET"]
end
