class StackSize
  include ActivePoro::Model
  belongs_to :pool

  attr_accessor :pool_id, :currency, :country, :stakes

  def initialize(args)
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
end
