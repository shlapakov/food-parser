require 'curb'
require 'nokogiri'

$XPATH_NAME = '//h1[contains(@class ,"product_main_name")]'
$XPATH_WEIGHT = '//span[contains(@class, "radio_label")]'
$XPATH_PRICE = '//span[contains(@class, "price_comb")]'
$XPATH_PIC = '//img[@id="bigpic"]/@src'

class Item
  def initialize(pic, name, price)
    @pic = pic
    @name = name
    @price = price
  end

  def name
    @name
  end

  def pic
    @pic
  end

  def price
    @price
  end
end


class ItemGetter
  def initialize(urls)
    @urls = urls
    @items = []
  end

  def get_items
    @urls.each_with_index { |url, i|
      puts("Parsing... (#{i+1}/#{@urls.size}) #{url}")
      http = Curl.get(url)
      html = Nokogiri::HTML(http.body)
      weights = html.xpath($XPATH_WEIGHT).to_a
      prices = html.xpath($XPATH_PRICE)
      pic = html.xpath($XPATH_PIC).to_s
      name = html.xpath($XPATH_NAME).first.content
      weights.each_with_index  { |weight, i|
        @items << Item.new(
            pic,
            name + ' - ' + weight,
            prices[i].text
        ) }

    }
  end

  def items
    @items
  end

end