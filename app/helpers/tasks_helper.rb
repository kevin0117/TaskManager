module TasksHelper
  def display_tag(tag_names)
    tag_names.map { |name|
      "<span class='badge badge-pill badge-light'>
      #{link_to name, tag_path(name)}
      </span>"}.join(' ').html_safe
  end
end
