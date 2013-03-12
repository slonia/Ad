 namespace :ad do
  task :publish => :environment do
    Ad.publish_all!
  end

	task :archive => :environment do
    Ad.archive_all!
  end

  task :alert do
  	puts "All right"
  end

 end
