module Linggle
  API_BASE = 'http://linggle.com'.freeze
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
    cookies = conn.get.env.response_headers['set-cookie']
    # TODO save token with'sdbm'
    # File.open '.linggle_cli'
    crsf_token_data = cookies.split('; ').map {|x| x.split('=', 0) }.to_h


    @csrf_token = crsf_token_data['csrftoken']
   end
 end
end
