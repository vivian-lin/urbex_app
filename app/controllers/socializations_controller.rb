class SocializationsController < ApplicationController
  before_filter :load_socializable

  def follow
    current_user.follow!(@socializable)
    flash[:alert] = 'You are now following ' + @socializable.username
    #render json: { follow: true }
    redirect_to '/profile/' + @socializable.username
  end

  def unfollow
    current_user.unfollow!(@socializable)
    flash[:alert] = 'You are no longer following ' + @socializable.username
    #render json: { follow: false }
    redirect_to '/profile/' + @socializable.username
  end

private
  def load_socializable
    @socializable =
      if id = params[:user_id]
        User.find(id)
      else
        raise ArgumentError, "Unsupported socializable model, params: " + params.keys.inspect
      end
    raise ActiveRecord::RecordNotFound unless @socializable
  end
end
