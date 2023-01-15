class UsersController < ApplicationController
    def index
        @users = User.all
    end
    
    def new
        @user = User.new
    end
    def create
        @user = User.new(email: params[:user][:email], password: params[:user][:password],
                        password_confirmation: params[:user][:password_confirmation])
        if @user.save
          flash[:notice] = '登録しました'
          session[:email] =@user.email
          redirect_to index_path
        else
          render new_user_path
        end
    end
    
    def destroy
        user = User.find(params[:id])
        user.destroy
        redirect_to users_path
    end
end
