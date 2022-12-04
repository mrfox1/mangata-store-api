module SessionService
  def sign_in(user)
    @current_user = user
    @current_session = user.sessions.create
  end

  def signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= current_session&.user
  end

  def current_session
    @current_session ||= Session.includes(:user).find_by_id(
      [
        params[:session_token],
        request.headers['Session-Token']
      ].compact.first
    )
  end

  def sign_out
    current_session&.destroy
    @current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end
end
