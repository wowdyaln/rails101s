class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.create(group_params)

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def edit
    @group = current_user.groups.find(params[:id])
  end

  def update
    @group = current_user.groups.find(params[:id])

    if @group.update(group_params)
      redirect_to group_path(@group), notice: "修改討論版成功！"
    else
      render :edit
    end
  end

  def destroy
    @group = current_user.groups.find(params[:id])

    if @group.destroy
      redirect_to groups_path, alert: "group has deleted!!"
    else
      render :index
    end
  end

  def join
    @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "你已經成功加入此group了！"

    else
      flash[:warning] = "你已經是此 group成員了"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:warning] = "你已經退出此 group，後回有期~"
    else
      flash[:danger] = "你還不是成員，退無可退"
    end

    redirect_to group_path(@group)
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

end
