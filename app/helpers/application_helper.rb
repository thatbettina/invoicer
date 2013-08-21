module ApplicationHelper

  # Open links in new window
  def link_to_external(name, options={})
    link_to(name, options, {target: "_blank"})
  end

end
