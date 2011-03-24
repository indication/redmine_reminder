module ApplicationHelper
  def issue_plain_string(issue)
    "* #{issue.due_date} - #{issue.project} - #{issue.tracker} ##{issue.id}: #{issue.subject} (" + 
      url_for(:controller => 'issues', :action => 'show', :id => issue, :only_path => false) + ")"
  end
end
