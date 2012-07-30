class AddVotesCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :votes_count, :integer, default: 0

    Post.reset_column_information
    Post.all.each do |p|
      Post.update_counters(p.id, votes_count: p.votes.length)
    end
  end
end
