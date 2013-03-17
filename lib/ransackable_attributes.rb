module RansackableAttributes
  extend ActiveSupport::Concern

  included do
    def self.ransackable_attributes auth_object = nil
      (column_names - self::UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
    end
  end

end
