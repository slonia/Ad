require 'spec_helper'
describe Ad do

  context "validation tests" do
    before(:each) {@ad = Ad.new(title: "Ad for test", description: "Description",city: "Minsk", price: 1, section_id: 1, user_id: 1)}

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
    before(:each) {@ad = Ad.new(title: "Ad for test", description: "Description",city: "Minsk", price: 1, section_id: 1, user_id: 1)}

    it "default state is 'draft'" do
      @ad.should be_draft
    end

    it "checking state path" do
      @ad.ready                       # from 'draft' to 'ready'
      puts "\t #{@ad.state}"
      @ad.should be_ready
      @ad.approve                     # from 'ready' to 'approve'
      puts "\t #{@ad.state}"
      @ad.should be_approve
      @ad.draft                       # from 'approve' to 'draft' - no path, should stay 'approve'
      puts "\t #{@ad.state}"
      @ad.should be_approve
      @ad.publish                     # from 'approve' to 'publish'
      puts "\t #{@ad.state}"
      @ad.should be_publish
      @ad.archive                     # from 'publish' to 'archive'
      puts "\t #{@ad.state}"
      @ad.should be_archive
      @ad.draft                       # from 'archive' to 'draft'
      puts "\t #{@ad.state}"
      @ad.should be_draft
    end
  end

end
