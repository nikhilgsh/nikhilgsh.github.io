# Local site verification

- Before running any Bundler or Jekyll command, load the system Ruby module with `module load ruby/3.3.5`.
- The repository already has its locked gems in `vendor/bundle`, selected by `.bundle/config`. Do not run `bundle install` or modify `Gemfile.lock` merely because the default system Ruby cannot find Jekyll.
- Verify the existing environment with `module load ruby/3.3.5; bundle check`. The expected Bundler version is 2.6.9.
- Build the site with `module load ruby/3.3.5; bundle exec jekyll build`.
- For an inspectable development server, run `module load ruby/3.3.5; bundle exec jekyll serve --host 0.0.0.0 --port <free-port> --livereload --livereload-port <free-port>`. Use distinct free ports for the site and LiveReload.
- A restricted sandbox may reject listening sockets with EventMachine's misleading `no acceptor (port is in use or requires root privileges)` message. When the chosen ports are not actually occupied, rerun the development server with permission to bind outside the sandbox.
- The default Ruby 3.0 environment is not the project environment and produces a misleading `bundler: command not found: jekyll` error.
- If `bundle check` fails after loading `ruby/3.3.5`, inspect the missing locked dependencies before considering any package installation.
