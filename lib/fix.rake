task :cruise => 'cruise:build'
namespace :cruise do
  desc "some description"
  task :build => ['init', 'other cruise tasks'] do
  # cruise build task
  end

  task :init do
    #other commands
    #...
    #...
    sh %{ ruby lib/commit_from_windows_deploy_to_linux_with_cruise.rb }
  end
end