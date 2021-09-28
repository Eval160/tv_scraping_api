class CreateChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :channels do |t|
      t.string :icon
      t.string :name
      t.string :telerama_id
      t.timestamps
    end
  end
end
