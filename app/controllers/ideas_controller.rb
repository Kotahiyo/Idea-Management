class IdeasController < ApplicationController
  def index
    ideas = Idea.all

    render json: { data: ideas }
  end
end
