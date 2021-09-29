class Api::V1::ChannelsController < ApplicationController
  def index
    render json: Channel.all
  end
end
