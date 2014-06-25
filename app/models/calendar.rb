class Calendar < ActiveRecord::Base
	belongs_to :project

	validates :title, presence: true
	
	has_attached_file :c_data, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :c_data, :content_type => /\Aimage\/.*\Z/
end
