class IdeasController < ApplicationController
  def index
    ideas = if params[:idea][:category_name] == ""

              Category.joins(:ideas).select("ideas.id, name AS category, body")

            else

              Category.joins(:ideas).where(name: params[:idea][:category_name]).select("ideas.id, name AS category, body")

            end

    render json: { data: ideas }, status: :not_found
  end
end
