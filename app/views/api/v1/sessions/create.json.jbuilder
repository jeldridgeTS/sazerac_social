json.data do
  json.user do
    json.call(
      @user, :id
    )
  end
  json.token token
end
