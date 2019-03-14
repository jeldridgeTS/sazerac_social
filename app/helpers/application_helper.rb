module ApplicationHelper
  def login_helper
    if current_user.is_a? GuestUser
      content_tag :div, class: "nav navbar-nav ml-auto w-100 justify-content-end" do
        "<li>".html_safe +
        (link_to "Register", new_user_registration_path, class: "btn btn-primary") + " ".html_safe +
        (link_to "Login", new_user_session_path, class: "btn btn-primary") +
        "</li>".html_safe
      end
    else
      "<li>".html_safe +
      link_to("Logout", destroy_user_session_path, method: :delete, class: "btn btn-primary") +
      "</li>".html_safe
    end
  end
end
