json.array!(@pools) do |pool|
  json.extract! pool, :id, :group_name, :group_order
  json.url pool_url(pool, format: :json)
end
