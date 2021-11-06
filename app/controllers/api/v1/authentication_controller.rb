module Api
    module V1
        class AuthenticationController < ApplicationController
            # before_action :authorized

            def create
                user = User.create({ name: user_params[:name], email: user_params[:email], password:BCrypt::Password.create(user_params[:password])})
                if user.valid?
                  token = encode_token({user_id: user.id})
                  render json: {user: user, token: token}
                else
                  render json: {error: "Invalid username or password"}
                end
              end
            
              # LOGGING IN
              def login
                user = User.find_by(email: params[:email])
                if user && BCrypt::Password.create(user_params[:password]) == user.password 
                  token = encode_token({user_id: user.id})
                  render json: {user: user, token: token}
                else
                  render json: {error: "Invalid username or password"}
                end
              end 
            private

            def user_params
                params.permit(:email, :password, :name)
            end
        end
    end
end
