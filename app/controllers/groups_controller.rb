class GroupsController < ApplicationController

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

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image_id,)
  end

end
