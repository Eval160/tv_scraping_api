class ProgramSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :sub_title, :category, :description, :duration, :start_time, :stop_time
  belongs_to :channel
  # has_one :channel
end
