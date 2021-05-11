class RoomsController < ApplicationController
  def index
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(params.require(:room).permit(:name, :description, :price, :address, :image, :user_id))
    if @room.save
      flash[:notice] = "部屋を登録しました"
      redirect_to new_room_path
    else
      render new_room_path
    end
  end

  def show
    @rooms = Room.where(user_id: current_user.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
