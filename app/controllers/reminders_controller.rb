class RemindersController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :edit, :update]

  def create
    @reminder = current_user.reminders.build(reminder_params)
    if @reminder.save
      flash[:success] = 'Se ha agregado el nuevo recordatorio.'
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    # code
  end

  def edit
    # code
  end

  def update
    # code
  end

  private

  def reminder_params
    params.require(:reminder).permit(:content, :when_activate)
  end
end
