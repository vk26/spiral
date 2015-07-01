class Apartment < ActiveRecord::Base
  has_many :assets
  validates :renter, :phone1, presence: true
  validates :phone1, format: { without: /[a-zA-Zа-яА-Я]/, message: I18n.t('.validation.apartment.phone') }
end
