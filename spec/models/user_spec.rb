require 'spec_helper'

describe User do
  context "ad management" do
    it "destroy draft ads with user" do
      @user = create(:user)
      @ad1 = create(:ad, user_id: @user.id)
      @ad2 = create(:ad,title: 'other', state: 'publish', user_id: @user.id)
      @user.destroy
      Ad.where(user_id: @user.id).should_not include(@ad1)
      Ad.where(user_id: @user.id).should include(@ad2)
    end
  end
end
