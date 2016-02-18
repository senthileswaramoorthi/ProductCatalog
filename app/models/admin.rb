class Admin < ActiveRecord::Base
validates :name, presence: true, uniqueness: true
validates :password, length: { in: 6..20 },  presence: true, confirmation: true
validates :confirm_password, length: { in: 6..20 },  presence: true

end
