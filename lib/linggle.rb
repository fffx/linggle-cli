require 'json'
require 'faraday'
require 'optionparser'
require 'colorize'
require 'terminal-table'
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
    puts 'No result' and return if results['ngrams'].size == 0
    table = Terminal::Table.new headings: ['Index', 'N-gram', 'Percent', 'Count'] do |t|
      t.style = { :border_top => false, :border_bottom => false }
      #t.style = {:all_separators => true}
      t.rows = results['ngrams'].take(10).map.with_index do |x, index|
        percent = '%.1f' % ( (x[1].to_f/results['total']) * 100)
        [index, x[0].green, "#{percent.yellow}%", x[1].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse]
      end
    end
    puts table
  end


  def self.parse()
    options = {}
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
