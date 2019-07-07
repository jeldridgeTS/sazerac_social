# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  respond_to :json

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      # Make cookie here for now
      # TODO: Signin/Login helper here
      jwt = Auth::JwtTokenAuth.issue_token({ user_id: @user.id })
      cookies.signed[:jwt] = { value: jwt, httponly: true }

      if resource.active_for_authentication?
        render json: resource
      else
        expire_data_after_sign_in!
        render json: resource
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :display_name, :first_name, :last_name, :password, :password_confirmation])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :display_name, :first_name, :last_name])
  end
end
