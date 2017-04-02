class PostsController < ApplicationController

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

  private

  def post_params
    params.require(:post).permit(:content) #还不熟
  end

end
