class UdaciList
  # include UdaciListErrors
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Default List"
    @items = {}
    @items[:types] = Array.new
    @items[:items] = Array.new
  end
  def add(type, description, options={})
    type = type.downcase
    if type == "todo"
      @items[:items] << TodoItem.new(description, options) 
      @items[:types] << type
    elsif type == "event"
      @items[:items] << EventItem.new(description, options) 
      @items[:types].push(type)
    elsif type == "link"
      @items[:items] << LinkItem.new(description, options) 
      @items[:types] << type
    else
      raise UdaciListErrors::InvalidItemType, "No exising type: '#{type}'!"
    end
  end
  def delete(index)
    if (index <= 0 || index > @items[:types].count)
      raise UdaciListErrors::IndexExceedsListSize, "Index '#{index}' out of range!"
    end
    @items[:items].delete_at(index - 1)
    @items[:types].delete_at(index - 1)
  end

  def change_priority(index, priority)
    # puts @types[index - 1]
    if @items[:types][index - 1] == "todo"
      # puts "here"
      @items[:items][index - 1].change_priority(priority)
    end
  end
  def postpone(index, days)
    @items[:items][index - 1].postpone(days)
  end
  def all
    rows = []
    @items[:items].each_with_index do |item, position|
      rows << [(position + 1).to_s + ')', @items[:types][position], item.details]
    end
    table = Terminal::Table.new(title: @title, rows: rows)
    puts table
  end
  def filter(type)
    res = []
    @items[:items].each_with_index do |item, position|
      if @items[:types][position] == type
        res << item 
      end
    end
    return res
  end
end
