class Sku < ActiveRecord::Base
	def self.search(search)
  where("i_id LIKE '%#{search}%' OR c_name LIKE '%#{search}%' OR value LIKE '%#{search}%' OR unit LIKE '%#{search}%'") 
end
end
