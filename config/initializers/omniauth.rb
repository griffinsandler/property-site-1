# Replace API_KEY and API_SECRET with the values you got from Facebook
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "486278861751569", "30ee848f2d84db8fb13ffb315d8965ea"
end