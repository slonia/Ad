# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


if Section.all.empty?
	sect = Section.new(:name => "Other")
	sect.save!
	puts "Default section created"
end

if User.where(:role=> "admin").empty?
	user = User.new(:name=>"admin",:email=>"admin@admin.ru", :password=>"admin123", :password_confirmation=>"admin123")
  user.role = :admin
	user.save!
	puts "Created admin with login 'admin' and password 'admin123'"
end

if User.where(:role=> "user").empty?
  user = User.new(:name=>"user",:email=>"user@admin.ru", :password=>"user123", :password_confirmation=>"user123")
  user.role = :user
  user.save!
  puts "Created user with login 'user' and password 'user123'"
end

if Ad.with_state("ready").empty?
  ad = Ad.new(:title => "Ready test ad",
              :description => "Description",
              :price=>1, :city=>"Test city",
              :user_id=>User.where(:role=> "user").first.id,
              :section_id=>Section.find(:first).id)
  ad.state = :ready
  ad.save!
  puts "Created test Ad"
end

if Ad.with_state("publish").empty?
  ad = Ad.new(:title => "Publish test ad",
              :description => "Description",
              :price=>1, :city=>"Test city",
              :user_id=>User.where(:role=> "user").first.id,
              :section_id=>Section.find(:first).id,
              :publish_date=>Date.today)
  ad.state = :publish
  ad.save!
  puts "Created test Ad"
end
