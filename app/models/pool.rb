class Pool < ActiveResource::Base
  self.site = 'http://api.sandbox.colossusbets.com/'

  has_many :stack_sizes

  schema do
    attribute 'id', :integer
    attribute 'name', :string
    attribute 'headline_prize', :float
    attribute 'status', :string
  end
end