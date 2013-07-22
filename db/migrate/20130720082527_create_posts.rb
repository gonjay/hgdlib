class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :time
      t.text :content
      t.string :images
      t.string :postUrl

      t.timestamps
    end
  end
end
