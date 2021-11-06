module Api
    module V1
        class UsersController < ApplicationController
            def index
                users = User.find('created_at DESC')
                render json:
                {
                    status: 'SUCCESS', message:"Loaded users", data: users
                }, status: :ok
                
            end 
            def show
                user = User.find(params[:id])
                render json:
                {
                    status: 'SUCCESS', message:"Loaded user", data: user
                }, status: :ok
            end
            def update
                user = User.find(params[:id])
                if user.update(user_params)
                    render json:
                    {
                        status: 'SUCCESS', message:"updated user", data: user
                    }, status: :ok 
                else
                    render json:
                    {
                        status: 'SUCCESS', message:"User not updated", data: user.errors
                    }, status: 500  
                end
            end
            def destroy
                user = User.find(params[:id])
                user.destroy
                render json:
                {
                    status: 'SUCCESS', message:"Deleted user", data: user
                }, status: :ok
            end

            private

            def user_params
                params.permit(:email, :password, :name)
            end
        end
    end
end