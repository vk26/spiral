class Apartment < ActiveRecord::Base
  validates :renter, :phone1, presence: true 
end
