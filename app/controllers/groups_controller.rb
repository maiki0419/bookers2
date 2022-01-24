class GroupsController < ApplicationController
  before_action :correct,only: [:edit,:update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id

    if @group.save
      @group_user = current_user.group_users.create(group_id: @group.id)
      redirect_to user_groups_path
    else
      render :new
    end
  end

  def join
    @group_user = current_user.group_users.create(group_id: params[:group_id])
    redirect_to user_groups_path
  end

  def out
    @group_user = GroupUser.find_by(user_id: params[:user_id],group_id: params[:group_id])
    @group_user.destroy
    redirect_to user_groups_path
  end

  def index
    @book = Book.new
    @groups = Group.all
    @group_user = GroupUser.all

  end

  def show
    @group = Group.find(params[:id])
    @book_new =Book.new
    if GroupUser.find_by(user_id: current_user, group_id: @group.id).present?
      @isgroup = true
    else
      @isgroup = false
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to user_group_path(current_user.id,@group.id)
    else
      render :edit
    end
  end

  def destroy

  end

  private


  def group_params
    params.require(:group).permit(:name, :introduction, :image_id,)
  end

  def correct
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to users_path
    end
  end

end
