class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.string :url
      t.string :title
      t.integer :rating, default: 0
      t.text :body
      t.timestamps
    end
  end
end
