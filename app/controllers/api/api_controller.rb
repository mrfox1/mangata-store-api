module Api
  class ApiController < ApplicationController
    include SessionService

    before_action :set_default_format, :set_locale, :authenticate

    rescue_from ActiveRecord::RecordNotFound, with: :not_found_record

    protected

    def authenticate
      if current_user.present?
        current_session.update_lifetime!
      else
        render_errors I18n.t('errors.access_denied'), :unauthorized
      end
    end

    def set_default_format
      request.format = :json
    end

    def set_locale
      locale = request.headers['locale']&.to_sym
      I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
    end

    def render_message(message)
      render json: { message: message }
    end

    def render_ok
      render_message I18n.t('messages.ok')
    end

    def render_errors(errors, status = :unprocessable_entity)
      render json: { errors: (errors.is_a?(Array) ? errors : [errors]) }, status: status
    end

    def render_error(error, status = :unprocessable_entity)
      render json: { error: error }, status: status
    end

    def not_found_record(exception)
      render_errors "#{ exception.model } #{ I18n.t('errors.not_found') }", :not_found
    end

    def permited_parameter
      @permited_parameter ||= proc { |key| params.permit(key).try(:[], key) }
    end
  end
end
