require 'spec_helper'
describe User do
  context "ad management" do
    it "destroy draft with user" do
      @user = create(:user)
      @ad1 = create(:ad, user_id: @user.id)
      @ad2 = create(:ad,title: 'other', state: 'publish', user_id: @user.id)
      @user.destroy
      Ads.where(user_id: @user.id).count.should_not include(@ad1)
      Ads.where(user_id: @user.id).count.should include(@ad2)
    end
  end

end
