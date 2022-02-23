namespace :spec do
  desc 'Run rspec against production server instead of local cassettes'
  task :production do
    if ENV['STREAMBIRD_TEST_API_KEY'].nil?
      raise 'Please specify STREAMBIRD_TEST_API_KEY to run against production server'
    end
    ENV['STREAMBIRD_TEST_SERVER'] = 'production'
    Rake::Task['spec'].invoke
  end
end
