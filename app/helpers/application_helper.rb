module ApplicationHelper
  def issue_plain_string(issue)
    "* #{reminder_date_formatter(issue.due_date)} - #{issue.project} - #{issue.tracker} ##{issue.id}: #{issue.subject} (" + 
      url_for(:controller => 'issues', :action => 'show', :id => issue, :only_path => false) + ")" + 
      " - #{date_diff_in_words(issue.due_date)} - #{issue.priority.name} - #{issue.status.name} - #{issue.done_ratio}%"
  end

  def issue_plain_string_watchable(issue)
    assignee = issue.assigned_to.nil? ? " - #{l(:mail_body_reminder_not_assigned)}": " - #{issue.assigned_to.name}" 
    issue_plain_string(issue) + assignee
  end

  def days_pluralized_count(days)
    day_tag=[l(:mail_reminder_all_day1),l(:mail_reminder_all_day2),l(:mail_reminder_all_day2),l(:mail_reminder_all_day2),l(:mail_reminder_all_day5)]
    day_tag[days>4 ? 4 : days-1 ]
  end

  def reminder_date_formatter(date)
    "#{date.day}-#{l(:date)[:abbr_month_names][date.month]}-#{date.year}"
  end

  def date_diff_in_words(date_to, date_from = Date.today)
    if (diff = date_to - date_from) >= 0 
      l(:mail_body_reminder_to_deadline, :days => diff, :day=> days_pluralized_count(diff))
    else
      l(:mail_body_reminder_past_due, :days => diff.abs, :day=> days_pluralized_count(diff.abs))
    end
  end
end
