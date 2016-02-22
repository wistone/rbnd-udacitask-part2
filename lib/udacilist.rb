class UdaciList
  # include UdaciListErrors
  attr_reader :title, :items, :type

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Default List"
    @items = []
    @types = []
    @todos = []
    @events = []
    @links = []
  end
  def add(type, description, options={})
    type = type.downcase
    if type == "todo"
      item  = TodoItem.new(description, options) 
      @types << type.colorize(:yellow)
      @todos << item
    elsif type == "event"
      item = EventItem.new(description, options) 
      @types << type.colorize(:green)
      @events << item
    elsif type == "link"
      item = LinkItem.new(description, options) 
      @types << type.colorize(:blue)
      @links << item
    else
      raise UdaciListErrors::InvalidItemType, "No exising type: '#{type}'!"
    end
    @items << item
  end
  def delete(index)
    if (index <= 0 || index > @items.count)
      raise UdaciListErrors::IndexExceedsListSize, "Index '#{index}' out of range!"
    end
    @items.delete_at(index - 1)
  end

  def change_priority(index, priority)
    # puts @types[index - 1]
    if @types[index - 1] == "todo".colorize(:yellow)
      # puts "here"
      @items[index - 1].change_priority(priority)
    end
  end
  def postpone(index, days)
    @items[index - 1].postpone(days)
  end
  def all
    rows = []
    @items.each_with_index do |item, position|
      rows << [(position + 1).to_s + ')', @types[position], item.details]
    end
    table = Terminal::Table.new(title: @title, rows: rows)
    puts table
  end
  def filter(type)
    return @todos if type == "todo"
    return @events if type == "event"
    return @links if type == "link"
  end
end
