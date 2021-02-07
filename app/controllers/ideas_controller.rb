class IdeasController < ApplicationController
  before_action :unprocessable_entity_error, :distinguish_categories, only: [:create]

  def index
    ideas = if params[:idea][:category_name] == ""

              Category.joins(:ideas).select("ideas.id, name AS category, body")

            else

              Category.joins(:ideas).where(name: params[:idea][:category_name]).select("ideas.id, name AS category, body")

            end

    render status: :not_found, json: { status: 404, message: "Not Found" } and return if ideas.empty?

    render json: { data: ideas } and return
  end

  def create
    idea = Idea.new(idea_params)
    idea.save!
    render status: :created, json: { data: idea, status: 201 } and return
  end

  private

    def idea_params
      params.require(:idea).permit(:body, :category_id).merge(category_id: $category_id)
    end

    def unprocessable_entity_error
      if Category.joins(:ideas).where(name: params[:idea][:category_name]).present? && params[:idea][:body].blank?
        render status: :unprocessable_entity, json: { status: 422 } and return
      end
    end

    def distinguish_categories
      request_category = Category.joins(:ideas).where(name: params[:idea][:category_name]).first

      if request_category.present? && params[:idea][:body].present?

        $category_id = request_category.id

      else

        new_category = Category.new(name: params[:idea][:category_name])
        new_category.save!
        $category_id = new_category.id

      end
    end
end
