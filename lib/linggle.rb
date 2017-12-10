require 'json'
require 'open-uri'
require 'optionparser'
require 'colorize'
require "linggle/version"
require 'linggle/api'
require 'linggle/string'

# resource
# https://kpumuk.info/ruby-on-rails/colorizing-console-ruby-script-output/
module Linggle

  # Your code goes here...
  def self.execute()

    args =  parse
    query_str = args.join(' ')
    # puts "parse result #{args}"
    
    # TODO rescue network exception, and follow redirections..
    puts query(query_str)

  end


  def self.parse()
    OptionParser.new do |parser|

      if ARGV.size == 0
        puts HELPS.map{|k,v| v }
        exit 0
      end

      parser.on("-h", "--help") do
        puts HELPS.map{|k,v| v }
        exit 0
      end

    end.parse!

  end
end
