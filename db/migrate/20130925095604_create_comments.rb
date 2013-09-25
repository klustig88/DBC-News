class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :post
      t.text :banter
      t.timestamps
    end
  end
end
