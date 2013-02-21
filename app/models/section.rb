class Section < ActiveRecord::Base
	has_many :ads
	UNRANSACKABLE_ATTRIBUTES = ["id","created_at","updated_at","section"]

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
