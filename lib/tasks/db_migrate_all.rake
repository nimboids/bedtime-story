namespace :db do
  namespace :migrate do
    desc "Migrate development, test and production databases"
    task :all => :environment do
      Dir.glob('config/environments/*.rb').map{|f| File.basename(f).sub(/\.rb$/, '')}.each do |env|
        puts "Migrating #{env} database..."
        ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[env])
        ActiveRecord::Migrator.migrate("db/migrate/")
        ActiveRecord::Base.remove_connection
      end
    end
  end
end
