# Linggle
Use Linggle(http://linggle.com/) in terminal, Linggle is not for translate, for translate purpose
, see [translate-shell](https://github.com/soimort/translate-shell)
![linggle cli](https://raw.githubusercontent.com/fffx/linggle-cli/master/assets/short.png)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'linggle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install linggle

## Usage

- 查询任意一至多个词
只要在你想要插入字词的位置使用* (星号)来查询一个词，或是_ (底线)来查询零至多个词就可以了。

```
present a method _
listen _ music
```



- 使用问号查询是否需要某个字
小明在报告里写了这么一句话：“I would like to discuss about the issue.”
回头检查时，总是觉得哪里怪怪的，他很怀疑“discuss”后面到底需不需要
加“about” ⋯⋯这时只要使用Linggle，在你不确定的字前加上? (问号)，Linggle就会告诉你需不需要这个字啰！

```
discuss ?about the issue
```

- 使用斜线号查询如何替换某字词
介系词这么多常常搞不清楚要用哪一个吗？太多字可以用却不知道哪一个比较适合吗？
让Linggle来告诉你该怎么选吧！很简单，只需要在你要抉择的两个字中间加入/ (斜线号)
就可以了！不只是介系词，其他词性也可以！

```
in/at the afternoon
play _ important role/part
```

- 使用任意词性查询搭配词
Linggle最大的特色，就是可以使用「关键词」配合「特定词性」来查询各种搭配词。比如说，
可以用v. death penalty来查询“death penalty”搭配的动词，效果不逊于一般搭配词典喔！
```
v. death penalty
acquire n.
```


- 精准的搭配词查询
想要更加精准的查询搭配词，我们就会建议使用复杂的查询式，例如在想要查询的动词前
加上一个“to”，让Linggle 不至于会错意。
```
to v. ?prep. ?det. difficulty/difficulties
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fangxing204/linggle.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
