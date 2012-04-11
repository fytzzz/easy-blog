class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :category_id, :default=> "1"
      t.integer :user_id, :default=>"1"
      t.string :title
      t.text :content
      t.integer :digs_count, :default => 0
      t.integer :views_count, :default => 0
      t.integer :visible, :default => 1
      t.string :permalink
      t.timestamps
    end
  end
end
