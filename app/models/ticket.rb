class Ticket < ActiveResource::Base
  attr_accessor :merchant_ref, :customer_id, :pool_id, :selections, :stake, :cost, :currency, :poc,
                :selections, :units_per_line, :lines, :amount_owned_customer, :status, :customer_payout

  self.site = 'http://api.sandbox.colossusbets.com/'

  schema do
    attribute 'merchant_ref', :string
    attribute 'customer_id', :string
    attribute 'pool_id', :integer
    attribute 'selections', :string
    attribute 'stake', :string
    attribute 'cost', :string
    attribute 'currency', :string
    attribute 'poc', :string
  end
end
