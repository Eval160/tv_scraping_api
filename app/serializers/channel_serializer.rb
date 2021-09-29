class ChannelSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :icon, :telerama_id
  has_many :programs
end
