class Api::V1::ChannelsController < ApplicationController
  def index
    @channels = Channel.all
    render json: ChannelSerializer.new(@channels).serializable_hash
  end

  def show
    options = { include: [:programs] }
    @channel = Channel.find(params[:id])
    render json: ChannelSerializer.new(@channel, options).serializable_hash
  end
end
