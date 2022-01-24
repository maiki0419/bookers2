class GroupsController < ApplicationController
  before_action :correct,only: [:edit,:update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @groupuser = current_user.group_users.create(group_id: @group.id)
    if @group.save
      redirect_to user_groups_path(current_user.id)
    else
      render :new
    end
  end

  def index
    @book = Book.new
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @book_new =Book.new
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
