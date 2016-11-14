module Permissions
  def fix!(application, writables, executables)
    run_locally do
      ## ensure application arg provided
      unless application
        error " please provide the name of the application..."
        exit 1
      end

      ## ensure htdocs directory for application exists
      unless test "[ -d /var/www/#{application}/htdocs ]"
        error " no application exists with the name '#{application}'"
        exit 1
      end

      warn "/var/www/#{application}/htdocs:"
      within "/var/www/#{application}/htdocs" do
        ## fix perms on all directories
        warn "-- updating directory permissions..."
        execute :find, '.',
          '-mindepth 1',
          '-type d',
          '-and -not -perm 2775',
          '-exec', 'chmod 2775 {} \;'

        ## fix perms on all files
        warn "-- updating file permissions..."
        execute :find, '.',
          '-mindepth 1',
          '-type f',
          '-and -not -perm 0664',
          '-exec', 'chmod 0664 {} \;'

        warn "-- setting owner/group..."
        execute :find, '.',
          '-mindepth 1',
          '-maxdepth 1',
          '-type d',
          '-and -not -path "./shared*"',
          '-exec', 'chown -R robot:users {} \;'

        unless executables.empty?
          executables.each do |executable_dir|
            if test "[ -d /var/www/#{application}/htdocs/#{executable_dir} ]"
              warn "/var/www/#{application}/htdocs/#{executable_dir}:"
              within "#{executable_dir}" do
                ## sest executable bit on everything in executable_dir
                warn "-- setting executable bit on symlink targets..."
                execute :find, '.',
                  '-mindepth 1',
                  '-maxdepth 1',
                  '-type l',
                  '-exec', 'chmod +x $(readlink -f {}) \;'

                warn "-- setting executable bit on files..."
                execute :find, '.',
                  '-mindepth 1',
                  '-maxdepth 1',
                  '-type f',
                  '-exec', 'chmod +x {} \;'
              end
            end
          end
        end

        ## share directory permissions
        unless writables.empty?
          warn "/var/www/#{application}/htdocs/shared:"
          within 'shared' do
            ## fix owner/group on all directories in 'shared', not writables
            warn "-- setting owner/group on non-writable directories and files..."
            execute :find, '.',
              '-mindepth 1',
              '-maxdepth 1',
              "-and -not -path #{writables.join('-and -not -path')}",
              '-exec', 'chown -R robot:users {} \;'

            ## fix owner/group on all files in 'shared', not writable
            warn "-- setting owner/group on writable directories and files..."
            execute :find, '.',
              '-mindepth 1',
              '-maxdepth 1',
              "-and -path #{writables.join('-and -path')}",
              '-exec', 'chown -R www-data:users {} \;'
          end
        else
          execute :find, '.',
            '-mindepth 1',
            '-maxdepth 1',
            '-exec', 'chown -R robot:users {} \;'
        end

      end
    end
  end
end
