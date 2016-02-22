class UdaciList
  include UdaciListErrors
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    if type == "todo"
      @items.push TodoItem.new(description, options) 
    elsif type == "event"
      @items.push EventItem.new(description, options) 
    elsif type == "link"
      @items.push LinkItem.new(description, options) 
    else
      raise InvalidItemType, "No exising type: '#{type}'!"
    end
  end
  def delete(index)
    if (index <= 0 || index > @items.count)
      raise IndexExceedsListSize, "Index '#{index}' out of range!"
    end
    @items.delete_at(index - 1)
  end
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
