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
                session[:user_id]=user.id
                redirect_to index_path
            else
                flash[:info] = "入力情報に誤りがあります"
                render top_login_path
            end
        else
            render top_login_path
        end
    end
    
    def logout
        #session.delete(:email)
        reset_session
        redirect_to index_path
    end
end
