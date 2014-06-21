class AddLastposterIdAndTimestampsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :last_poster_id, :integer
    add_column :posts, :last_post_at, :datetime
  end
end
