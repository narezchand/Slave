namespace :pantheon do

	task :setup do
		before 'deploy:starting', 'pantheon:check'
		after 'deploy:publishing', 'pantheon:deploy'
	end

	desc 'Ensure terminus is installed and the user is logged in'
	task :check do
		run_locally do
			#verify that :pantheon_env is set

			#verify that we have user data
			username = fetch(:pantheon_username)
			pass = fetch(:pantheon_password)
			if !username || !pass
				warn ':pantheon_username and :pantehson_password should be set in your $HOME/.capfile'
				abort
			end

			#verify that terminus is installed
			installed = system("which terminus > /dev/null 2>&1")
			if !installed
				warn '`which terminus` returned empty.  Please be sure terminus is installed locally, https://github.com/pantheon-systems/cli.'
				abort
			end

			#verify that terminus is logged in as the proper user
			whoami = system('terminus auth whoami')
			if whoami != "You are authenticated as #{username}"
				execute :terminus, 'auth', 'login',
					username,
					"--password='#{pass}'"
			end
		end
	end

	desc 'Deploy to stage'
	task :deploy do
	    if fetch(:pantheon_env) != 'dev'
            run_locally do
                execute :terminus, 'site', 'deploy',
                    "--site='#{fetch(:pantheon_site)}'",
                    "--env='#{fetch(:pantheon_env)}'",
                    "--note='deploying source rev:\##{fetch(:src_revision)}'"
                    "--cc"
            end
        end
	end
end