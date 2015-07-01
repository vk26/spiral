class Asset < ActiveRecord::Base
  belongs_to :apartment
  has_attached_file :photo, :styles => { :medium => "600x480>", :thumb => "60x48>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
