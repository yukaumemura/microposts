class ClipsController < ApplicationController
  def create


    @user_id = current_user.id
    @event_id = Event.find(params[:id]).id
    @clip = Clip.new(event_id: @event_id, user_id: @user_id)


      if @event.save
        redirect_to user_path(current_user)
      end

  end

  def destroy
    @clip = Clip.find(params[:id])
    if @clip.destroy
      redirect_to user_path(current_user)
    end
  end

end
