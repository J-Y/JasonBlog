require 'fileutils'
require 'active_record/fixtures'

namespace :fixtures do

  task :seed => :environment do
    def task_timer
      start = Time.now
      yield
      puts "Time elapsed: #{Time.now - start} seconds"
    end

    task_timer do
      db_conn = ActiveRecord::Base.connection()

      # Disable constraints so we don't have to worry about FK problems
      #db_conn.execute "EXEC sp_msforeachtable \"ALTER TABLE ? NOCHECK CONSTRAINT all\""

      Dir.glob("#{Rails.root}/db/fixtures/*.yml").each do |file|
        puts "Creating fixtures for: #{File.basename(file, '.*')}"
        ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/db/fixtures", File.basename(file, '.*'))
      end

      # Re-enable constraints
      #db_conn.execute "EXEC sp_msforeachtable \"ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all\""
    end
  end

end
