module Api
  module V1
    class UsersController < BaseController
      skip_before_action :authenticate, only: %i[create]

      def profile
        render json: { current_user: current_user.info }
      end

      def update
        filtered_params = profile_params
        if current_user.social? && (params[:remove_image].present? || params[:image].present?)
          filtered_params[:self_update] = true
        end

        current_user.assign_attributes filtered_params
        if current_user.save
          profile
        else
          render_errors current_user.errors.full_messages
        end
      end

      def create
        @user = User.new create_params
        if @user.save
          sign_in @user
          render json: { session_token: current_session&.id, current_user: current_user.info }
        else
          render_errors @user.errors.full_messages
        end
      end

      def destroy
        current_user.destroy
        render_ok
      end

      private

      def init
        status = :not_found
        @user ||= User.find_by id: params[:id]
        error_message = I18n.t('errors.user_not_found')
        render_errors error_message, status if @user.blank?
      end

      def create_params
        params.permit :email,
                      :phone_number,
                      :password,
                      :password_confirmation,
                      :first_name,
                      :last_name,
                      :state,
                      :city,
                      :address
      end

      def profile_params
        params.permit :first_name,
                      :last_name,
                      :image,
                      :remove_image,
                      :email,
                      :phone_number,
                      :state,
                      :city,
                      :address,
                      :self_update
      end
    end
  end
end
