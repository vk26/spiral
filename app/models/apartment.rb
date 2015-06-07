class Apartment < ActiveRecord::Base
  validates :renter, :phone1, presence: true 
  validates :phone1, format: { without: /[a-zA-Zа-яА-Я]/, message: 'Номер телефона не должен содержать буквы'}
end
