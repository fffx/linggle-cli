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
    args =  parse()
    query_str = args.join(' ')
    # puts "parse result #{args}"
    
    # TODO rescue network exception, and follow redirections..
    entries = query(query_str)
    # {
    #   "count"=>13966963,
    #   "count_str"=>"14,000,000",
    #   "percent"=>"54.5%",
    #   "phrase" => 
    #       ["very", "good"]
    # }
    entries = entries.take(20).map do |e|
      "#{e['phrase'].join(' ').green}   频率: #{e['count_str'].yellow}  #{e['percent']} \n #{e['percent'].percent_line} \n \n"
    end
    puts entries
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
