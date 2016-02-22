module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(30)
  end
  def format_priority(priority)
    value = " ⇧" if priority == "high"
    value = " ⇨" if priority == "medium"
    value = " ⇩" if priority == "low"
    value = "" if !priority
    return value
  end
  def format_date_due(due)
    due ? due.strftime("%D") : "No due date"
  end
  def format_date_start_end(start_date, end_date)
    dates = start_date.strftime("%D") if start_date
    dates << " -- " + end_date.strftime("%D") if end_date
    dates = "N/A" if !dates
    return dates
  end
  def format_name(site_name)
    site_name ? site_name : ""
  end
end
