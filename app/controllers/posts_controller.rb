class PostsController < ApplicationController
  before_action :find_group
  before_action :authenticate_user!


  def new

    @post = @group.posts.new
  end

  def create

    @post = @group.posts.build(post_params)

    if @post.save
      redirect_to group_path(@group),notice: "新增文章成功"
    else
      render :new
    end
  end

  def edit

    @post = @group.posts.find(params[:id])
  end

  def update

    @post = @group.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to group_path(@group), notice: "成功更新文章！"
    else
      render :edit
    end
  end

  def destroy

    @post = @group.posts.find(params[:id])
    @post.destroy
    redirect_to group_path(@group), alert: "post has deleted!!"
  end

    private

    def post_params
      params.require(:post).permit(:content)
    end

    def find_group
      @group = Group.find(params[:group_id])
    end

end
