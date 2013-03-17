class Section < ActiveRecord::Base
  include RansackableAttributes

  UNRANSACKABLE_ATTRIBUTES = %w[id created_at updated_at section]

	has_many :ads, dependent: :nullify
end
