require 'curb'
require 'nokogiri'

$XPATH_PRODUCT = '//div[@class="product-container"]/div/div/a/@href'

class Category
  def initialize(url)
    @url = url
    @links_to_products = []
  end

  def get_site_html
    http = Curl.get(@url)
    @html = Nokogiri::HTML(http.body)
  end

  def get_links_to_products
    links = @html.xpath($XPATH_PRODUCT)
    links.each do |link|
      @links_to_products << link.value
    end
    puts @links_to_products
  end

end