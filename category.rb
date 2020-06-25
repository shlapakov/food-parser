require 'curb'
require 'nokogiri'


class Category
  def initialize(url)
    @url = url
    @links_to_products = []
  end

  def get_list_of_products
    http = Curl.get(@url)
    html = Nokogiri::HTML(http.body)
    puts html
  end
end