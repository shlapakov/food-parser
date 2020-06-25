require 'curb'
require 'nokogiri'

$XPATH_ITEM = '//div[@class="product-container"]/div/div/a/@href'

class Category
  def initialize(url)
    @url = url
    @links_to_items = []
  end

  def get_links_to_items
    p = 1
    begin
      http = Curl.get(@url + "?p=#{p}")
      http = Curl.get(@url) if p == 1 #needs to load first page
      html = Nokogiri::HTML(http.body)
      links = html.xpath($XPATH_ITEM)
      links.each do |link|
        @links_to_items << link.value
      end
      puts "I just loaded page \##{p}" if links.size > 0
      p += 1
    end while links.size > 0
    puts "Total links – #{@links_to_items.size}"
    end

  def products
    @links_to_items
  end
end