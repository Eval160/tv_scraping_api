class CreatePrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :programs do |t|
      t.string :title
      t.string :sub_title
      t.string :category
      t.datetime :start_time
      t.datetime :stop_time
      t.string :description
      t.integer :duration

      t.timestamps
    end
  end
end
