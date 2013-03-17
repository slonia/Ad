class Ad < ActiveRecord::Base
  include RansackableAttributes

	UNRANSACKABLE_ATTRIBUTES = %w[id section_id user_id state]
	MULTIPLE_ACTS=[:draft,:ready,:reject,:approve,:destroy]

	belongs_to :section
	belongs_to :user

	has_many :assets, :dependent => :destroy
	accepts_nested_attributes_for :assets


	validates :title,:description,:price,:section_id, presence: true
	validates :title, :uniqueness => { :scope => :section_id }
	validates :title, :length => { :minimum => 3 }
	validates :price, :numericality => {:greater_than_or_equal_to => 1}
	validates :description, :length => { :minimum => 8 }

	state_machine initial: :draft do
		state :draft
		state :ready
		state :reject
		state :approve
		state :publish
		state :archive

		event :draft do
			transition :to => :draft, :from => [:reject,:archive]
		end

		event :ready do
			transition :to => :ready, :from => [:draft]
		end

		event :reject do
			transition :to => :reject, :from => [:ready]
		end

		event :approve do
			transition :to => :approve, :from => [:ready]
		end

		event :publish do
			transition :to => :publish, :from => [:approve]
		end

		event :archive do
			transition :to => :archive, :from => [:publish]
		end

	end

  def self.publish_all!
  	@ads = Ad.with_state('approve')
		@ads.each do |ad|
			ad.publish_date = Date.today
			ad.publish
			puts "##{ad.id} #{ad.title} was published"
		end
  end

  def self.archive_all!
  	@ads = Ad.with_state('publish').where{publish_date<= 3.days.ago}
  	@ads.each do |ad|
      ad.archive
      puts "##{ad.id} #{ad.title} was archived"
  	end
  end
end
