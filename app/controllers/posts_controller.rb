class PostsController < ApplicationController
  def bright_ideas
  	@user = User.find(session[:user_id])
  	@posts= Post.find_by_sql("select p.id, p.content, count(l.id) likes, u.alias, u.id userid from posts p left join likes l on post_id=p.id left join users u on u.id = p.user_id group by l.post_id order by likes desc")
  end

  def delete
  end

  def create
  	Post.create(user_id: session[:user_id], content: params[:post][:content])
  	redirect_to :back
  end

  def add_like
  	# likes = Like.find_by_sql("select count(*) as cnt from likes where post_id=#{params[:id]} and user_id=#{session[:user_id]} ")
  	# if likes[0][:cnt] == 0
  	 	Like.create(post_id: params[:id], user_id: session[:user_id])
  	# end
  	redirect_to '/bright_ideas'
  end

  def bright_ideas_detail
    @user = User.find_by_sql("select distinct p.content, u.id, u.alias poster,u2.id userid, u2.name, u2.alias from posts p join users u on u.id = p.user_id left join likes l on l.post_id = p.id left join users u2 on u2.id = l.user_id where p.id = #{params[:id]}" )
  end

   private 
  def post_params
    params.require(:post).permit(:content)
  end
end
