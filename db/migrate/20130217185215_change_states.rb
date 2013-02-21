class ChangeStates < ActiveRecord::Migration
  def up
  	change_table :ads do |t|
      t.change :state, :string
    end
  end

  def down
  end
end
