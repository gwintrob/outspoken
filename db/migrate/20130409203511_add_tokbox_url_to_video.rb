class AddTokboxUrlToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :tokbox_url, :string
  end
end
