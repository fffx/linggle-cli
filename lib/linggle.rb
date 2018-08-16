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
    return if args.nil? && args.size < 1
    query_str = args.drop(0).join(' ')

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
    results['ngrams'].take(20).each do |x|
      percent = ( (x[1].to_f/results['total']).round(2) * 100 ).to_s
      puts "#{x[0].green}   Percent: #{percent.yellow}  #{x[1]} \n #{percent.percent_line} \n \n"
    end
  end


  def self.parse()
    OptionParser.new do |parser|

      parser.banner = 'Linggle Command Line Interface:\n availale options: \n \n'
      if ARGV.size == 0
        puts parser
        puts HELPS.map{|k,v| v }
        exit 0
      end

      parser.on("-u", "--usage", 'Show  Usages') do
        puts HELPS.map{|k,v| v }
        exit 0
      end

      parser.on("-h", "--help", 'Show This Help') do
        puts parser
        puts HELPS.map{|k,v| v }
      end

      parser.on('-V', '--version', 'Show Version') do
        puts "Linggle CLI Version: #{VERSION}"
        exit 0
      end


      parser
    end.parse!

  end
end
