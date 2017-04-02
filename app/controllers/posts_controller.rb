class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create]
  def new
    @group = Group.find(params[:group_id]) #还不熟
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group #应该是把group的参数赋予post的group属性
    @post.user = current_user #应该是把current_user参数赋予post的user属性

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to account_posts_path, notice: 'Update post success'
    else
      render :edit
    end
  end



  def destroy
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])

    @post.destroy
    redirect_to account_posts_path, alert: 'Post deleted'
  end



  private

  def post_params
    params.require(:post).permit(:content) #还不熟
  end

end
