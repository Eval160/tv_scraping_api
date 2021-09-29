class Api::V1::ProgramsController < ApplicationController
  def index
    @programs = Program.search(params)
    render json: ProgramSerializer.new(@programs).serializable_hash
  end
end
