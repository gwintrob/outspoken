class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :tokbox_id

      t.timestamps
    end
  end
end
