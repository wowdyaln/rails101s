class PostsController < ApplicationController
  require 'pry'

  binding.pry

  before_action :find_group, except: [:index]
  before_action :authenticate_user!
  before_action :require_member, except: [:index]




  def new

    @post = @group.posts.new
  end

  def create

    @post = @group.posts.build(post_params)
    @post.author = current_user

    if @post.save
      redirect_to group_path(@group),notice: "新增文章成功"
    else
      render :new
    end
  end

  def edit

    @post = current_user.posts.find(params[:id])
  end

  def update

    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to group_path(@group), notice: "成功更新文章！"
    else
      render :edit
    end
  end

  def destroy

    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to group_path(@group), alert: "post has deleted!!"
  end


  def index
    @posts = Post.all
  end

    private

    def post_params
      params.require(:post).permit(:content)
    end

    def find_group
      @group = Group.find(params[:group_id])
    end

    def require_member
      if !current_user.is_member_of?(@group)
        redirect_to group_path(@group)
        flash[:warning] = "發文前，請先加入此group"
      end
    end

end
