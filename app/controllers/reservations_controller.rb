class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    @room = Room.find(params[:room_id])
    @user = User.find(@room.user_id)
  end

  def confirm
    if user_signed_in?
      @reservation = Reservation.new(permit_params)
      @day_count = @reservation.end_date - @reservation.start_date
      @room = Room.find(@reservation.room_id)
      @reservation.price = @room.price * @day_count.to_i * @reservation.people_count
      @reservation.user_id = current_user.id
      if @reservation.invalid?
        render :new
      elsif @reservation.start_date < Date.today
        flash[:alert] = "過去の日付は入力できません"
        redirect_to reservations_new_path(room_id: @reservation.room_id)
      end
    else
      flash[:alert] = "ログインしてください"
      render new_user_session_path
    end
  end

  def complete
    @reservation = Reservation.new(permit_params)
    @room = Room.find(@reservation.room_id)
    if @reservation.save
      flash[:notice] = "予約が完了しました"
    else
      render :new
    end
  end

  def show
    @reservations = current_user.reservations
  end

  private
  def permit_params
    params.require('reservation').permit(:start_date, :end_date, :people_count, :price, :user_id, :room_id)
  end
end
