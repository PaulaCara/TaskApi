class Session < ActiveResource::Base
  self.site = 'http://api.sandbox.colossusbets.com/'

  schema do
    attribute 'id', :integer
    attribute 'access_token', :string
    attribute 'refresh_token', :string
    attribute 'api_key', :string
    attribute 'api_secret', :string
  end
end
