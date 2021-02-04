class IdeasController < ApplicationController
  def index
    ideas = Category.joins(:ideas).select('ideas.id, name AS category, body')

    render json: { data: ideas }
  end
end
