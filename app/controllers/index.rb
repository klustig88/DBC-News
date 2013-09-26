get '/' do 
  @posts = Post.all
  @users = User.all
  erb :index
end

get '/comments' do 
  erb :comments
end

get '/userpage/:username' do
  @user = User.find_by_username(params[:username])
  erb :user
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

get '/user/:username' do 
  if session[:id]
    @user = User.find_by_username(params[:username])
    erb :user
  else
    redirect to ('/')
  end
end

get '/post/:post_id' do 
  @post = Post.find_by_id(params[:post_id])
  @comments = @post.comments
    @user = User.find_by_id(@post.user_id)
  erb :post
end



####------------------------POST

post '/login' do
  # @validate = User.authenticate(params[:username], params[:password])
  # if @validate 
   @current_user = User.find_by_username(params[:username])
    session[:id] = @current_user.id
    redirect to ("/user/#{@current_user.username}")
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
  if @post.user_id == nil
   @user = User.find_by_username('anonymous')
   @post.user_id = @user.id
   @post.save
  end
  redirect to ("/post/#{@post.id}")
end

post '/addcomment/:post_id' do 
  @comment = Comment.create(banter: params[:banter], user_id: session[:id], post_id: params[:post_id])
  @post = Post.find_by_id(params[:post_id])
  redirect to "/post/#{@post.id}"
end



post '/upvote/:id' do 
  @post = Post.find_by_id(params[:id])
  @post.rating += 1
  @post.save
  redirect to "/"
end



