module GroupsHelper
  def render_group_title(group)
    truncate(simple_format(group.title), lenth: 30)
  end
end
