class RoomsController < ApplicationController
  def index
    if params[:area] != nil
      area = params[:area]
      @rooms = Room.where('address LIKE?', "%#{area}%")
      @number_of_rooms = Room.where('address LIKE?', "%#{area}%").count
    elsif params[:keyword] != nil
      keyword = params[:keyword]
      @rooms = Room.where(['name LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%"])
      @number_of_rooms = Room.where(['name LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%"]).count
    end
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
end
