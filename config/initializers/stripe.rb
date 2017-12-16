if Rails.env != 'test'
  stripe_settings = YAML::load(File.open("#{Rails.root.to_s}/config/stripekeys.yml"))
  Stripe.api_key = stripe_settings[:secret_key]
end
