module Api
  # include SessionService

  class ApiController < ApplicationController
    # helper_method SessionService.instance_methods
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_record

    protected

    def render_errors(errors, status = :unprocessable_entity)
      render json: { errors: (errors.is_a?(Array) ? errors : [errors]) }, status: status
    end

    def render_error(error, status = :unprocessable_entity)
      render json: { error: error }, status: status
    end

    def not_found_record(exception)
      render_errors "#{ exception.model } #{ I18n.t('errors.not_found') }", :not_found
    end
  end
end
