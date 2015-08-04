class Apartment < ActiveRecord::Base
  TYPES = ["1к", "2к", "3к", "4к и более", "к", "койк", "общ", "Неблагоустр. дом", "Благоустр. дом", "посуточно", "неизвестно", "Пансионат", "Гостинка", "Малосемейка", "Студия", "Жилой гараж"]
  SOURSE = %w["OWN", "AVITO", "IRR"]
  REPAIR = %w["обычный", "евро", "черновой"]
  has_many :assets, :dependent => :destroy
  accepts_nested_attributes_for :assets, allow_destroy: true
  validates :renter, :phone1, presence: true
  validates :phone1, format: { without: /[a-zA-Zа-яА-Я]/, message: I18n.t('.validation.apartment.phone') }

end
