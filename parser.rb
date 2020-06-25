require_relative 'category'
require_relative 'item'
require_relative 'csv_maker'


url_to_parse = ARGV[0]
file_name = ARGV[1]
puts "Trying to parse #{url_to_parse}"
start_time = Time.now
category = Category.new(url_to_parse)
category.get_links_to_products
items = ItemGetter.new(category.products)
items.get_items
CSVMaker.write_csv(items.items, file_name)
puts "Time of parsing – #{Time.now - start_time} seconds."
