json.current_user do
  json.display_name current_user.display_name
  json.email_address current_user.email
  json.first_name current_user.first_name
  json.last_name current_user.last_name
end
