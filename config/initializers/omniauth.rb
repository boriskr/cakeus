Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'N9bJod82CQ9sMJFE4bMYg', 'KTbUk0uWavDzcyFI7ECSyS5u1fX09lzLsN9xrqDW6XQ'
  provider :facebook, "289182667771833", "cc3efac1f7996bb9c4f8a4fb713149d1"
end
