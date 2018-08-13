require 'json'
require 'faraday'
require 'optionparser'
require 'colorize'
require "linggle/version"
require 'linggle/api'
require 'linggle/string'
require 'linggle/help_doc'

# resource
# https://kpumuk.info/ruby-on-rails/colorizing-console-ruby-script-output/
module Linggle

  # Your code goes here...
  def self.execute()
    args =  parse()
    query_str = args.join(' ')

    # TODO rescue network exception, and follow redirections..
    results = Api.new.query(query_str)
=begin
     {
         "query": "go ?to schoo",
         "time": 1534167385507,
         "ngrams": [
             ["go to school", 667988],
             ["go school", 6137]
          ],
          "total": 674125
      }
=end
    entries = results['ngrams'].take(20).map do |x|
      percent = ( (x[1].to_f/results['total']).round(2) * 100 ).to_s
      "#{x[0].green}   Percent: #{percent.yellow}  #{x[1]} \n #{percent.percent_line} \n \n"
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
