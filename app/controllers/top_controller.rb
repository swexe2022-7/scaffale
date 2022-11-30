class TopController < ApplicationController
    def main
        if session[:email]
            render top_main_path
        else
            render top_login_path
        end
    end
    
    def login
        user = User.find_by(email: params[:email])
        if user
            login_password = BCrypt::Password.new(user.pass)
            if login_password == params[:pass]
                session[:email] = user.email
                redirect_to top_main_path
            else
                flash[:info] = "入力情報に誤りがあります"
                render top_login_path
            end
        else
            render top_login_path
        end
    end
    
    def logout
        session.delete(:email)
        redirect_to top_main_path
    end
end
