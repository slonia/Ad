 namespace :ad do
  task :publish => :environment do
    Ad.pub
  end

	task :archive => :environment do
    Ad.arc
  end

  task :alert do
  	puts "All right"
  end

 end
