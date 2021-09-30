class Program < ApplicationRecord
  belongs_to :channel
  validates :title, :start_time, :stop_time, presence: true
  default_scope { order("start_time ASC") }

  scope :daily_programs, -> { where('stop_time > ? ', Time.now).where('start_time < ? ', Time.now + 1.day) }
  scope :filter_by_channel, -> (telerama_id) { joins(:channel).where('channels.telerama_id' => telerama_id) }

  def self.search(params = {})
    programs = Program.all
    programs = programs.daily_programs if params[:daily]
    programs = programs.filter_by_channel(params[:channel]) if params[:channel]
    programs
  end
end
