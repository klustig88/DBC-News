get '/' do 
  erb :index
end

get '/comments' do 
  erb :comments
end

get '/user/posts' do 
  erb :user_posts
end

get '/user/comments' do 
  erb :user_comments
end

get '/login' do 
  erb :login
end

get '/addpost' do
  erb :add_post
end

get '/logout' do
  session.clear
  redirect to ('/')
end

get '/:post_id' do 
  @post = Post.find_by_id(params[:post_id])
  if @post.user_id == nil
    @user = User.find_by_id(2)
  else
    @user = User.find_by_id(@post.user_id)
  end
  erb :post
end

get '/:username' do 
  if session[:id]
    @user = User.find_by_username(params[:username])
    erb :user
  else
    redirect to ('/')
  end
end

####------------------------POST

post '/login' do
  # @validate = User.authenticate(params[:username], params[:password])
  # if @validate 
   @current_user = User.find_by_username(params[:username])
    session[:id] = @current_user.id
    redirect to ("/#{@current_user.username}")
  # else
  #   redirect to ('/')
  # end
end

post '/signup' do
  @user = User.create(username: params[:username], password: params[:password])
  session[:id] = @user.id
  redirect to ('/')
end

post '/addpost' do
  @post = Post.create(title: params[:title], body: params[:body], url: params[:url], user_id: session[:id])
  redirect to ("/#{@post.id}")
end



