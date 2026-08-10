# Environment for building this site locally on a Flatiron workstation.
#
#   source bin/dev-env.sh
#   bundle install          # first time only
#   bundle exec jekyll serve
#
# Three things on these machines get in the way of a stock `bundle install`,
# and this script works around each:
#
#   1. /usr/bin/ruby is 2.5.9, too old for Jekyll 4 and for Bundler itself.
#      Lmod provides 3.3.5.
#   2. Rocky 8 ships glibc 2.28, but nokogiri's precompiled x86_64-linux gem
#      needs >= 2.29, so native gems have to be built from source.
#   3. An active conda environment exports CFLAGS and puts its own linker on
#      PATH, and that linker cannot find the system -lz / -lcrypt. Building
#      nokogiri fails until conda is out of the way.
#
# Gems land in ~/.gem-alfolio, outside the repo, so nothing shows up in
# `git status`. Note that `bundle install` does modify Gemfile.lock, adding
# generic-platform entries; leave that change uncommitted, since the GitHub
# Actions runner builds on a newer glibc and uses the precompiled gems.

# Ruby 3.3.5 via Lmod.
source /etc/profile.d/modules.sh
module load ruby/3.3.5

# Drop the conda toolchain: its compiler flags and its linker both break the
# nokogiri build.
unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS CC CXX LD CPP FC F77 F90 AR RANLIB NM
unset CONDA_PREFIX LD_LIBRARY_PATH
export PATH="$(printf '%s' "$PATH" | tr ':' '\n' | grep -v miniforge3 | paste -sd:)"

# Build native gems from source rather than fetching binaries built against a
# newer glibc than this OS has.
export BUNDLE_FORCE_RUBY_PLATFORM=true

# Without a UTF-8 locale Ruby reads files as US-ASCII and Liquid dies on the
# accented characters in _bibliography/papers.bib.
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"

export GEM_HOME="$HOME/.gem-alfolio"
export BUNDLE_PATH="$GEM_HOME/bundle"
export PATH="$GEM_HOME/bin:$PATH"
