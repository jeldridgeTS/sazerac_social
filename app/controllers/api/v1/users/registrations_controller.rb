class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_action :authenticate
  skip_before_action :verify_authenticity_token

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.save
    if resource.persisted?
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
end
