class Settlement
  attr_accessor :id, :merchant_ref, :status, :customer_id, :customer_payout, :merchant_settlement_currency,
                :merchant_settlement_amount, :customer_currency, :pool_id

  def initialize(args)
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def self.to_collection(args, params)
    args.map do |result|
      s = Settlement.new(result)
      s.pool_id = params[:id]
      s
    end
  end

  def self.get_by_id(args, params)
    args.each do |result|
      s = Settlement.new(result)
      return s if s.id == params[:id]
    end
  end

end