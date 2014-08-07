# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

if ENV['RAILS_ENV'] && %w"production demo staging".include?(ENV['RAILS_ENV'].downcase)
  puts "Cannot seed base data to #{ENV['RAILS_ENV']} environment"
else
  Dir.glob("#{Rails.root}/db/fixtures/*.yml").each do |file|
    puts "Loading base data for: #{File.basename(file, '.*')}"
    ActiveRecord::FixtureSet.create_fixtures("#{Rails.root}/db/fixtures", File.basename(file, '.*'))
  end
end
