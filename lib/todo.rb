class TodoItem
  include Listable, UdaciListErrors
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Date.parse(options[:due]) : options[:due]
    if (options[:priority]!="high" && options[:priority]!="middle" && options[:priority]!="low" && options[:priority]!=nil)
      raise InvalidPriorityValue, "Invalid Priority Value: '#{options[:priority]}'"
    end
    priority = options[:priority]
  end
  def details
    format_description(@description) + "due: " +
    format_date_due(due) +
    format_priority(@priority)
  end
end
