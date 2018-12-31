class GuestUserPolicy < UserPolicy
  def list_users?
    false
  end
end
