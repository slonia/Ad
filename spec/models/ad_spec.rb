require 'spec_helper'
describe Ad do
  let(:val_ad) { Ad.new(title: 'Title',description: 'Description', price: 1, user_id: 1, section_id: 1)}
  let(:inval_ad) {Ad.new}

  it "Ad can be valid" do
    val_ad.should be_valid
  end

  it "Blank ad is invalid" do
    inval_ad.should_not be_valid
  end

end
