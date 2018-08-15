require 'fileutils'
require 'sdbm'
require 'date'
module Linggle
  API_BASE = 'http://linggle.com'.freeze
  STORE_PATH = "#{ENV['HOME']}/linggle_cli".freeze
  TIMEOUT = 3
  COLORS = {
    e: :yellow, # example
    t: :blue # title
  }
  class Api
    attr_reader :conn

    def initialize
      @conn = Faraday.new(url: API_BASE) do |f|
        f.request  :url_encoded
        f.response :logger
        f.adapter  Faraday.default_adapter
      end
    end
    ##
    # 查询返回结果示例
    #
    # {"query": "go ?to schoo", "time": 1534167385507, "ngrams": [["go to schoo", 234]], "total": 234}
    #

   def query(query_str)



      # puts "conent #{content}"
      res = conn.post '/query/', {query: query_str, time: Time.now.to_i}.to_json do |req|
        puts csrf_token
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-Requested-With'] = 'XMLHttpRequest'
        req['Cookie'] = "csrftoken=#{csrf_token}"
        req.headers['X-CSRFToken'] = csrf_token
      end
      puts res
      puts res.body
      JSON.parse(res.body)
   end


   private
   def csrf_token
    return @csrf_token if @csrf_token

    FileUtils.mkdir STORE_PATH unless File.exists?(STORE_PATH)
    SDBM.open "#{STORE_PATH}/.linggle_cli" do |db|
      expires  = DateTime.parse(db['expires']) rescue nil
      if expires && expires > DateTime.now && (@csrf_token = db['csrf_token'])
        return @csrf_token
      else
        cookies = conn.get.env.response_headers['set-cookie'].split('; ').map {|x| x.split('=', 0) }.to_h
        db['expires'] = cookies['expires']
        @csrf_token = db['csrf_token'] = cookies['csrftoken']
      end
    end
   end
 end
end
