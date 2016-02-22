class TodoItem
  include Listable
  attr_reader :description, :priority, :due_chronic

  def initialize(description, options={})
    @description = description
    @due = options[:due_date] ? Date.parse(options[:due_date]) : options[:due_date]
    @due = options[:due_chronic] ? Chronic.parse(options[:due_chronic]) : @due
    if ((options[:priority]!="high" && options[:priority]!="medium" && options[:priority]!="low") && options[:priority]!=nil)
      raise UdaciListErrors::InvalidPriorityValue, "Invalid Priority Value: '#{options[:priority]}'"
    end
    @priority = options[:priority]
  end
  def details
    format_description(@description) + "due: " +
    format_date_due(@due) +
    format_priority(@priority)
  end
  def change_priority(priority)
    if (priority!="high" && priority!="medium" && priority!="low")
      raise UdaciListErrors::InvalidPriorityValue, "Invalid Priority Value: '#{priority}'"
    end
    @priority = priority
  end
  def postpone(days)
    @due = @due + 3600*24*days
    # puts @due
  end
end
