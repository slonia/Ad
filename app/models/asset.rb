class Asset < ActiveRecord::Base
	belongs_to :ad
	attr_accessible :image
	has_attached_file :image
end
