require 'csv'
class CSVMaker
  def self.write_csv(items, file_name)
    puts "Trying to make csv file..."
    CSV.open(file_name, 'w') do |csv|
      csv << %w[Name Price Image]
      items.each do |item|
        csv << [item.name,
                /[-]?[0-9]+(.[0-9]+)?/.match(item.price),
                item.pic
        ]
      end
      puts "#{file_name} created. #{items.size} items saved."
    end
  end
end