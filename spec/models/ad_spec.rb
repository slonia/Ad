require 'spec_helper'
describe Ad do

  context "validation tests" do
    before(:each) {@ad = build(:ad)}

    it "is valid with all params" do
      @ad.should be_valid
    end

    it "is valid without city" do
      @ad.city = nil
      @ad.should be_valid
    end

    it "is invalid without title" do
      @ad.title = nil
      @ad.should_not be_valid
    end

    it "is invalid without description" do
      @ad.description = nil
      @ad.should_not be_valid
    end

    it "is invalid without price" do
      @ad.price = nil
      @ad.should_not be_valid
    end

    it "is invalid with negative price" do
      @ad.price = -1
      @ad.should_not be_valid
    end
  end

  context "state tests" do
    it "default state is 'draft'" do
      @ad = build(:ad)
      @ad.should be_draft
    end

    it "from 'draft' to 'ready'" do
      @ad = build(:ad)
      @ad.ready
      @ad.should be_ready
    end

    it "from 'ready' to 'reject'" do
      @ad = build(:ad, state: :ready)
      @ad.reject
      @ad.should be_reject
    end

    it "from 'ready' to 'approve'" do
      @ad = build(:ad, state: :ready)
      @ad.approve
      @ad.should be_approve
    end

    it "from 'approve' to 'publish'" do
      @ad = build(:ad, state: :approve)
      @ad.publish
      @ad.should be_publish
    end

    it "from 'publish' to 'archive'" do
      @ad = build(:ad, state: :publish)
      @ad.archive
      @ad.should be_archive
    end

    it "from 'ready' to 'publish' should be 'ready', not 'publish'" do
      @ad = build(:ad, state: :ready)
      @ad.publish
      @ad.should_not be_publish
    end
  end

  context "ad management" do
    it "publish all" do
      @ad1 = create(:ad, title: 'test1', state: :approve)
      @ad2 = create(:ad, title: 'test2')
      @ad3 = create(:ad, title: 'test3', state: :approve)
      Ad.publish_all!
      Ad.with_state(:publish).should include(@ad1, @ad3)
      Ad.with_state(:publish).should_not include(@ad2)
    end

    it "archive all" do
      @ad1 = create(:ad, title: 'test1', state: :publish, publish_date: 5.days.ago)
      @ad2 = create(:ad, title: 'test2')
      @ad3 = create(:ad, title: 'test3', state: :publish, publish_date: 4.days.ago)
      Ad.archive_all!
      Ad.with_state(:archive).should include(@ad1, @ad3)
      Ad.with_state(:archive).should_not include(@ad2)
    end
  end

end
