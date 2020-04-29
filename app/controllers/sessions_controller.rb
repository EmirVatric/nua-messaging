class SessionsController < ApplicationController

  def change_user
    type = params[:type]
    if type == 'admin'
      session[:user] = User.admin.first.id
    elsif type == 'doctor'
      session[:user] = User.doctor.first.id
    else 
      session[:user] = User.current.id
    end

    redirect_to messages_path
  end
end