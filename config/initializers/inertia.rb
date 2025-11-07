InertiaRails.configure do |config|
  # Set the version to enable automatic asset refreshing
  config.version = ViteRuby.digest

  # Configure the layout
  config.layout = "application"
end
