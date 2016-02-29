# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'fae28765b85d0f1e69ca', '55bda2d413833e43d0cc8401a61a3d7dbded6110', scope: "user:email,user:follow"
  provider :facebook, '1580062212284655', '09ce8b0e6dadcb645f3739d77e462890'
end
