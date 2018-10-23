class Media
  require 'open-uri'
  require 'uri'
  require 'csv'

def self.start
  key_words = ["長野 お土産",
               "小布施 お土産",
               "安曇野 お土産",
               "松本 お土産",
               "塩尻 お土産",
               "諏訪 お土産",
               "上田 お土産",
               "軽井沢 お土産",
               "佐久 お土産",
               "伊那 お土産",
               "阿智村 お土産",
               "木曽 お土産"]

  #CSVファイルへのヘッダー書き込み
  CSV.open("./result/media.csv","wb") do |csv|
    csv << ['キーワード','タイトル','URL']

    key_words.each do |keyword|
      p "#{keyword}"
      url = "https://www.google.co.jp/search?q=#{keyword}"
      url_escape = URI.escape(url)
      user_agent = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.63 Safari/537.36'
      charset = nil
      html = open(url_escape, "User-Agent" => user_agent) do |f|
        charset = f.charset
        f.read
      end

      # <div class="r">-ここにはさまれた文字列-</div>を集める
      strings =  html.scan(%r{div class="r">(.+?)</div>})
      puts strings

      # <a>タグの中のhref属性とタイトルを抜き出す
      for i in 0...strings.length do
        url,ping ,title = (strings[i][0].scan(%r{<a href="(.+?)"(.+?)><h3 class="LC20lb">(.+?)</h3>}))[0]
        csv << [keyword,title,url]
      end
    end
  end
end

end

Media.start
