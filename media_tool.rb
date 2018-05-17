class Media
  require 'open-uri'
  require 'uri'
  require 'csv'

def self.start
  key_words = ["東京　ランチ","渋谷　居酒屋"]

  #CSVファイルへのヘッダー書き込み
  CSV.open("./result/media.csv","wb") do |csv|
    csv << ['キーワード','タイトル','URL']

    key_words.each do |keyword|
      url = "https://www.google.co.jp/search?q=#{keyword}"
      url_escape = URI.escape(url)
      user_agent = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.63 Safari/537.36'
      charset = nil
      html = open(url_escape, "User-Agent" => user_agent) do |f|
        charset = f.charset
        f.read
      end

      # <h3 class="r">-ここにはさまれた文字列-</h3>を集める
      strings =  html.scan(%r{<h3 class="r">(.+?)</h3>})

      # <a>タグの中のhref属性とタイトルを抜き出す
      for i in 0...strings.length do
        url, title = (strings[i][0].scan(%r{<a href="(.+?)".+?>(.+?)</a>}))[0]
        puts "#{title} #{url}"
      end

      csv << [keyword,title,url]
    end
  end
end

end

Media.start
