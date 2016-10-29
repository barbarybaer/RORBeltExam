class UsersController < ApplicationController
  def main
  end

 def register
	u=User.new(user_params)
	if u.save
		user = User.last
		session[:user_id] = user.id
		redirect_to "/bright_ideas"
	else
		flash[:errors] = u.errors.full_messages
		redirect_to :back
	end
  end

  def login
  	user = User.find_by(email: params[:email])
    if (user && user.authenticate(params[:password])) 
      session[:user_id] = user.id
      redirect_to "/bright_ideas"
    else
      flash[:errors] = ["Invalid email or password"]
      redirect_to :back
    end



  end

  def logout
  	session.clear
	  redirect_to '/main'
  end

  def users_detail
    @user = User.find_by_sql("select distinct u.name, u.alias, u.email, count(p.id) as posts, count(l.id) as likes from users u join posts p on p.user_id = u.id join likes l on l.post_id = p.id where u.id = #{params[:id]}")
    @posts = Post.find_by_sql("select count(id) cnt from posts where user_id = #{params[:id]}")
    
    # redirect_to "/bright_ideas/#{session[:user_id]}"
  end

  private 
  def user_params
    params.require(:user).permit(:name, :alias, :email, :password, :password_confirmation)
  end
end