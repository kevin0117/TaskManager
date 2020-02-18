module UsersHelper
  def user_role(x)
    x ? t('attributes.users.admin') : t('attributes.users.member')
  end
end
