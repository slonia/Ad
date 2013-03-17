class Asset < ActiveRecord::Base
  attr_accessible :image

	belongs_to :ad

	has_attached_file :image
end
