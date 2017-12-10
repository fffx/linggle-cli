require 'json'
require 'open-uri'
require 'optionparser'
require "linggle/version"
module Linggle
  API = 'http://linggle.com/query'.freeze
  TIMEOUT = 10
  # Your code goes here...
  def self.execute

    query = ""
    
    # TODO rescue network exception, and follow redirections
    content = open(
      URI::encode("#{api}/query"),
      read_timeout: TIMEOUT
    ).read

    entries = JSON.parse(content)

  end


  def self.parse
    OptionParser.new do |parser|
    parser.banner = "Usage: hello.rb [options]"

    parser.on("-h", "--help", "Show this help message") do ||
      puts parser
    end

    end.parse!

  end
end
