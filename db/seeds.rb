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
	user = User.new(:name=>"admin",:email=>"admin@admin.ru", :password=>"admin123", :password_confirmation=>"admin123", :role=>:admin)
	user.save!
	puts "Created admin with login 'admin' and password 'admin123'"
end