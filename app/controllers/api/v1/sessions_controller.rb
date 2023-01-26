module Api
  module V1
    class SessionsController < BaseController
      skip_before_action :authenticate, only: %i[create]

      def create
        if permited_parameter[:email].blank?
          render_errors "Email #{I18n.t('errors.blank')}"
          return
        end

        @user = User.find_by email: permited_parameter[:email]

        if @user&.authenticate?(params[:password])
          sign_in @user
          render json: { session_token: current_session&.id, current_user: current_user.info }
        else
          render_errors I18n.t('errors.wrong_email_or_password'), :unauthorized
        end
      end

      def destroy
        sign_out
        render_ok
      end
    end
  end
end
