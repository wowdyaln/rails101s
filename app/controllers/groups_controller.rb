class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(group_params)

    if @group.save
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
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      redirect_to group_path(@group), notice: "修改討論版成功！"
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])

    if @group.destroy
      redirect_to groups_path, alert: "group has deleted!!"
    else
      render :index
    end
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

end
