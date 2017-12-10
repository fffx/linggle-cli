module Linggle
  API = 'http://linggle.com/query'.freeze
  TIMEOUT = 10
  COLORS = {
    e: :yellow, # example
    t: :blue # title
  } 

##
# 查询返回结果
#
# [
#  {"count"=>13966963, "count_str"=>"14,000,000", "percent"=>"54.5%", "phrase"=>["very", "good"]}
#  {"count"=>4436461, "count_str"=>"4,400,000", "percent"=>"17.3%", "phrase"=>["pretty", "good"]}
#  {"count"=>562220, "count_str"=>"560,000", "percent"=>"2.2%", "phrase"=>["only", "good"]}
#  {"count"=>508737, "count_str"=>"510,000", "percent"=>"2.0%", "phrase"=>["real", "good"]}
#  {"count"=>481831, "count_str"=>"480,000", "percent"=>"1.9%", "phrase"=>["public", "good"]}
#  {"count"=>480872, "count_str"=>"480,000", "percent"=>"1.9%", "phrase"=>["damn", "good"]}
#  {"count"=>429867, "count_str"=>"430,000", "percent"=>"1.7%", "phrase"=>["common", "good"]}
#  {"count"=>409578, "count_str"=>"410,000", "percent"=>"1.6%", "phrase"=>["other", "good"]}
#  {"count"=>308328, "count_str"=>"310,000", "percent"=>"1.2%", "phrase"=>["good", "good"]}
#  {"count"=>303609, "count_str"=>"300,000", "percent"=>"1.2%", "phrase"=>["still", "good"]}
#  {"count"=>256591, "count_str"=>"260,000", "percent"=>"1.0%", "phrase"=>["just", "good"]}
#  {"count"=>225266, "count_str"=>"230,000", "percent"=>"0.9%", "phrase"=>["sound", "good"]}
#  {"count"=>207530, "count_str"=>"210,000", "percent"=>"0.8%", "phrase"=>["like", "good"]}
#  {"count"=>191120, "count_str"=>"190,000", "percent"=>"0.7%", "phrase"=>["greater", "good"]}
#  ...
# ]

 def self.query(query_str)
    content = open(
      URI::encode("#{API}/#{query_str}"),
      read_timeout: TIMEOUT
    ).read

    # puts "conent #{content}"
    entries = JSON.parse(content)
 end

 HELPS = {
    '_' => <<-DOC,
    #{'查询任意一至多个词'.bold.colorize(COLORS[:t])}
        只要在你想要插入字词的位置使用* (星号)来查询一个词，或是_ (底线)来查询零至多个词就可以了。

        #{ 'present a method _
        listen _ music'.colorize(COLORS[:e]) }


    DOC

  '?' => <<-DOC,
    #{'使用问号查询是否需要某个字'.blue}
        小明在报告里写了这么一句话：“I would like to discuss about the issue.”
        回头检查时，总是觉得哪里怪怪的，他很怀疑“discuss”后面到底需不需要
        加“about” ⋯⋯这时只要使用Linggle，在你不确定的字前加上? (问号)，Linggle就会告诉你需不需要这个字啰！

        #{'discuss ?about the issue'.colorize(COLORS[:e]) }


    DOC

  '/' => <<-DOC,
    #{'使用斜线号查询如何替换某字词'.blue}
        介系词这么多常常搞不清楚要用哪一个吗？太多字可以用却不知道哪一个比较适合吗？
        让Linggle来告诉你该怎么选吧！很简单，只需要在你要抉择的两个字中间加入/ (斜线号)
        就可以了！不只是介系词，其他词性也可以！

        #{ 'in/at the afternoon
        play _ important role/part'.colorize(COLORS[:e]) }


    DOC

  'w.' => <<-DOC,
    #{'使用任意词性查询搭配词'.blue}
        Linggle最大的特色，就是可以使用「关键词」配合「特定词性」来查询各种搭配词。比如说，
        可以用v. death penalty来查询“death penalty”搭配的动词，效果不逊于一般搭配词典喔！

        #{ 'v. death penalty
        acquire n.'.colorize(COLORS[:e]) }


    DOC

  'more' => <<-DOC,
    #{'精准的搭配词查询'.blue}
        想要更加精准的查询搭配词，我们就会建议使用复杂的查询式，例如在想要查询的动词前
        加上一个“to”，让Linggle 不至于会错意。

        #{'to v. ?prep. ?det. difficulty/difficulties'.colorize(COLORS[:e]) }


    DOC
  }.freeze
end
