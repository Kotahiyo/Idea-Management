class IdeasController < ApplicationController
  def index

    if params[:idea][:category_name] == ""

      ideas = Category.joins(:ideas).select('ideas.id, name AS category, body')

    else

      ideas = Category.joins(:ideas).where(name: params[:idea][:category_name]).select('ideas.id, name AS category, body')

    end

    render json: { data: ideas }, status: :not_found
  end
end
