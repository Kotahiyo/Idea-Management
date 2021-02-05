class IdeasController < ApplicationController
  def index
    ideas = if params[:idea][:category_name] == ""

              Category.joins(:ideas).select("ideas.id, name AS category, body")

            else

              Category.joins(:ideas).where(name: params[:idea][:category_name]).select("ideas.id, name AS category, body")

            end

    render status: :not_found, json: { status: 404, message: "Not Found" } and return if ideas.empty?

    render json: { data: ideas } and return
  end
end
