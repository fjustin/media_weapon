require 'nokogiri'
require 'open-uri'
require 'csv'


CSV.open("./result/media.csv", "wb") do |csv|
  csv << ['タイトル','URL']
  urls = [
    'https://www.wantedly.com/projects?type=mixed&page=1&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad&hiring_types%5B%5D=internship%27',
    'https://www.wantedly.com/projects?type=mixed&page=2&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=3&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=4&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=5&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=6&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=7&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=8&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=9&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=10&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=11&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=12&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=13&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=14&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=15&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=16&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=17&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=18&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=19&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=20&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=21&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=22&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=23&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=24&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=25&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=26&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=27&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=28&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=29&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=30&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=31&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=32&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=33&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=34&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=35&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
    'https://www.wantedly.com/projects?type=mixed&page=36&occupation_types%5B%5D=marketing&occupation_types%5B%5D=others&occupation_types%5B%5D=sales&occupation_types%5B%5D=director&hiring_types%5B%5D=newgrad',
  ]

  charset = nil
  urls.each do |url|
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    doc.xpath('//h1[@class="project-title"]').each do |node|
      title = node.css('a').inner_text
      #titles.push(title)
      link = node.css('a').attribute('href').value
      #links.push(link)
      p title

      csv << [title,link]
    end
  end
end
