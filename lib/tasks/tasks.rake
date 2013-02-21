 namespace :ad do
  task :publish => :environment do
    @ads = Ad.with_state('approve');
		@ads.each do |ad|
				ad.publish
				puts "##{ad.id} #{ad.title} was published"
		end
  end

	task :archive => :environment do
    @ads = Ad.with_state('publish').where{updated_at<= 3.days.ago};
		@ads.each do |ad|
			ad.archive
			puts "##{ad.id} #{ad.title} was archived"
		end
  end

  task :alert do 
  	puts "All right"
  end

 end