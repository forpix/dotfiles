alias q exit

Pry.config.editor = 'mvim -f --nomru -c "au VimLeave * !open -a iTerm"'

require 'ostruct'
require 'thread'
require 'date'
require 'fileutils'
require 'net/http'
require 'json'
require 'yaml'
require 'pathname'
require 'time'
require 'securerandom'

Thread.abort_on_exception = true

begin
  require 'letters'
rescue LoadError => e
end

Pry.config.prompt = proc do |obj, level, _|
  prompt = ""
  prompt << "#{Rails.version}@" if defined?(Rails)
  prompt << "#{RUBY_VERSION}"
  "#{prompt} (#{obj})> "
end

if defined?(Rails)
  begin
    require "rails/console/app"
    require "rails/console/helpers"
  rescue LoadError => e
    require "console_app"
    require "console_with_helpers"
  end
end

begin
  require "awesome_print"
  Pry.config.print = proc {|output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)}
rescue LoadError => err
  warn "=> Unable to load awesome_print"
end
