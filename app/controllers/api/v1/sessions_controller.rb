class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    puts "====================================================================="
    puts params
    puts "====================================================================="

    @user = User.where(email: params[:email]).first

    puts "*********************************************************************"
    puts "USER INFO:"
    puts @user.inspect
    puts "*********************************************************************"

    # binding.pry

    puts "*********************************************************************"
    puts "SECRET:"
    puts Rails.application.secrets.secret_key_base
    puts "*********************************************************************"

    secret = Rails.application.secrets.secret_key_base || ENV['SECRET_KEY_BASE']

    if @user&.valid_password? params[:password]
      jwt = JWT.encode(
                  { user_id: @user.id, exp: (Time.now + 2.weeks).to_i },
                  secret,
                  'HS256'
                )

      render :create, status: 200, locals: { token: jwt }
    else
      # render :json, { error: 'invalid_credentials' }
      respond_to do |format|
        format.json {
          render :plain => { error: 'invalid_credentials' }.to_json, content_type: 'application/json'
          # render :json, { error: 'invalid_credentials' }
        }
      end

    end
  end

  def destroy
    #code
  end
end
