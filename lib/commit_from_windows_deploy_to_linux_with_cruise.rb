gem_file = File.read("Gemfile")
replace = gem_file.gsub(/(.*)gem (.*)win32(.*)\n/, "")
File.open("Gemfile", "w") {|file| file.puts replace}


gem_file_lock = File.read("Gemfile.lock")
# remove windows specific gems
replace = gem_file_lock.gsub(/(.*)win32(.*)\n/, "")
# update the gems to have correct extensions
replace = replace.gsub(/-x86-mingw32/, "")
# store the correct platform
replace = replace.gsub(/PLATFORMS\n  x86-mingw32\n/, "PLATFORMS\n  ruby\n")
# remove any other instance of mingw
replace = replace.gsub(/(.*)mingw(.*)\n/, "")
File.open("Gemfile.lock", "w") {|file| file.puts replace}

# run bundle install && commit Gemfile.lock to svn, i.e. svn ci Gemfile.lock if there is any changes
exec "bundle && svn ci Gemfile Gemfile.lock -m 'updated Gemfile and Gemfile.lock with *nix version' --username <user_name> --password <password>"