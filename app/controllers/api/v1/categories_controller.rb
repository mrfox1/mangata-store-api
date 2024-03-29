module Api
  module V1
    class CategoriesController < BaseController
      def index
        @categories = Category.all
      end

      def show
        @category = Category.find(params[:id])
      end
    end
  end
end
