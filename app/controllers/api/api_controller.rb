module Api
  # include SessionService

  class ApiController < ApplicationController
    # helper_method SessionService.instance_methods
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_record
  end
end
