class Section < ActiveRecord::Base

  UNRANSACKABLE_ATTRIBUTES = %w[id created_at updated_at section]

	has_many :ads, dependent: :nullify

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
