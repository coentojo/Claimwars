#production
# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :facebook, '107845582672007', '6dc91fa714e16587ffc0d17da7936c62'
# end

#development
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '107845582672007', '6dc91fa714e16587ffc0d17da7936c62'
end
