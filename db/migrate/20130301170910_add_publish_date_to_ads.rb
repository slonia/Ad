class AddPublishDateToAds < ActiveRecord::Migration
  def up
    add_column :ads, :publish_date, :datetime
  end

  def down
    remove_column :ads, :publish_date
  end
end
